def cns():
    words = {}
    word_file = open("noswearing.txt","r")
    for line in word_file:
        line = line.strip()
        line = line.lower()
        line = line.split(' - ')
        words[line[0]] = line[1]
    return words
def write_file():
    import csv
    with open('noswearing.csv', 'w') as csvfile:
        writer = csv.writer(csvfile, delimiter=',',
                            quotechar='|')
        word_file = open("noswearing.txt", "r")
        for line in word_file:
            line = line.strip()
            line = line.lower()
            line = line.split(' - ')
            writer.writerow(line)

def read_csv():
    import csv
    words = {}
    csvfile = open('noswearing.csv', 'r')
    header = csvfile.readline()
    f = open('noswearingclean.csv', 'w')
    writer = csv.writer(f, delimiter=',', quotechar='|')
    writer.writerow(header.split(',')[:2])
    for line in csvfile:
        line = line.strip()
        line = line.split(',')
        if line[2] == '1':
            writer.writerow(line[:2])
    csvfile.close()
    f.close()
read_csv()

