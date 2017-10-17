import re,os,codecs

def text_process(f1,f2):
    print f1,f2
    lines = [line.strip().decode('utf8') for line in f1]
    i=0
    while i<len(lines):
        line = lines[i]
        print line
        if "\"STYLE11\"><a href" in line:
            line = line.replace("</p>","")
            line = line.strip("<p class=\"STYLE11\">")
            f2.write(line[line.find('>')+1:-6]+"\n")
            line = lines[i+1]
            f2.write(line+"\n")
            line = lines[i+4]
            f2.write(line[line.find("img/")+4:line.find(".gif")]+"\n")
            i+=5
        i+=1


if not os.path.exists('./Process'):
    os.mkdir('./Process')

pathDir = os.listdir('./Download')
for file in pathDir:
    with open('./Download/'+file, 'r') as f1:
        f2 = codecs.open('./Process/'+file,'w','utf8') 
        text_process(f1,f2)
        
