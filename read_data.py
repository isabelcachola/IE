import csv
def count_txt():
    #word_file = open("bad-words.txt","r") #944,484
    word_file = open("isabelswords.txt","r") # 61,320
    words = []
    for line in word_file:
        words.append(line.strip())

    words = words[1:]

    with open('Sentiment Analysis Dataset.csv') as f:
        count = 0
        reader = csv.DictReader(f)
        for row in reader:
            text = row['SentimentText'].lower()
            for word in words:
                if word in text:
                    count += 1
                    break
    print(count)

# 497,402
def count_csv():
    import clean_no_swearing as cns
    words = cns.read_csv()
    words = list(words.keys())
    with open('Sentiment Analysis Dataset.csv') as f:
        count = 0
        reader = csv.DictReader(f)
        for row in reader:
            text = row['SentimentText'].lower()
            for word in words:
                if word in text:
                    count += 1
                    break
    print(count)
