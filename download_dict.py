import urllib2
import os
import requests
import codecs
import sys
import chardet

def download():
    urls = []
    failed_list = []
    with open('urls.txt', 'r') as f:
        for line in f.read().split('\n'):
            url_link = line.split(' ')[0]
            url_type = line.split(' ')[1]
            #calculate the number of pages. e.g 40词->4页  48词->5页
            url_num = (int(line.split(' ')[2])+9)/10
            for i in range(1,int(url_num)+1):
                url = url_link+"&p="+str(i)         # get the exact url link 
                try:    
                    print(url)                      
                    req = urllib2.Request(url)      # get the web 
                    resp = urllib2.urlopen(req)
                    r = resp.read()
                    filename = './Download/'+url_type+'_'+str(i)+'.txt'
                    print 'Has created '+filename+' :)'
                    f2 = codecs.open(filename, 'w','utf8')
                    f2.write(r.decode('gb2312').encode('utf8')) # save the web into file
                except Exception,e:
                    print e
                    failed_list.append(url)     

    # record the failed download links 
    print('{0} failed download'.format(len(failed_list)))
    with open('failed urls1.txt', 'w') as f:
        f.write('\n'.join(failed_list))

#set the encoding & new the directory
reload(sys)
sys.setdefaultencoding("utf-8") 
if not os.path.exists('./Download'):
    os.mkdir('./Download')
#do the download
download()