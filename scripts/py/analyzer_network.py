# -*-coding:utf-8 -*-
import sys
import re


def gen_node(s):
    # s: id@ip
    tmp = s.split("@")
    id = tmp[0]
    ip = tmp[1]
    idx = re.match("\d+\.\d+\.\d+\.(\d+)\:\d+", ip)
    name = "node{}".format(int(idx.group(1))-100)
    return {
        "id": id,
        "ip": ip,
        "name": name,
        "neighbors": [],
    }


def output_dict(table, h1="head", h2="vals"):
    keys = h1
    data = h2

    for key in table:
        keys += ",{}".format(key)
        data += ",{}".format(table[key])
    print(keys)
    print(data)


def output_list(lst, head=""):
    line = head
    for data in lst:
        line += ",{}".format(data)

    print(line)


def gen_graphviz(nodes):
    template = '''
{head}
{node_def}
{node_link}
{end}
'''
    node_def = ""
    node_link = ""
    
    for name in nodes:
        n = nodes[name]
        node_def+='{}[label="{}\\n{}"]\n'.format(name,n["name"],n['ip'])
        
        for nn in n["neighbors"]:
            node_link+="{}->{}\n".format(name,nn)
    
    parameters = {
        "head":"digraph g {",
        "node_def": node_def,
        "node_link": node_link,
        "end":"}"
    }
    return template.format(**parameters)


def analyzer(neighbor_filename):
    nodes = {}  # key:node name, value: {id, name, ip, neighbor_list}

    with open(neighbor_filename, "r") as f:
        lines = f.readlines()
        for line in lines:
            line = line.replace("\n", "")
            tmp = line.split("#")
            n = gen_node(tmp[0])
            neighbors = tmp[1].split(',')
            n["neighbors"] = [gen_node(neighbor)["name"]
                              for neighbor in neighbors]
            key = n["name"]
            if key not in nodes:
                nodes[key] = n
            else:
                nodes[key]["neighbors"] = n["neighbors"]

    # 输出每个节点被选为邻居的次数
    reversed_nodes = {n: 0 for n in nodes}
    for name in nodes:
        n = nodes[name]
        for nn in n["neighbors"]:
            reversed_nodes[nn] += 1
    print("节点被选为邻居次数")
    output_dict(reversed_nodes)

    # 输出是否有节点把自己当邻居
    print("是否有节点的邻居包含自己:")
    loop = []
    for name in nodes:
        if name in nodes[name]["neighbors"]:
            loop.append(name)
    output_list(loop)

    print('输出graphviz dot数据')
    dot = gen_graphviz(nodes)
    with open("./test/network.dot","w") as f:
        f.write(dot)


if __name__ == "__main__":
    filename = sys.argv[1]
    analyzer(filename)
