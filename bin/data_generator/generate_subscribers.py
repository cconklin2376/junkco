
import random


'''
sbid = ''
phoneno = ''
acctno = ''

acodes = ['441','312','278','504']
bcodes = 

modified on 5-1-14 to shuffle and shuffled nums manually


'''

nums = ['3','1','9','0','4','6','5','7','8','2']

allcodes = [a+b+c+d for a in nums for b in nums for c in nums for d in nums]





numbers = []
firstnames = []
lastnames = []

def getRandomPhoneNo():
	ac = random.randint(111,999)
	nc = random.randint(111,999)
	lf = random.randint(1001,9999)
	return str(ac) + '-' + str(nc) + '-' + str(lf)

def writeuser(a,f,l):
	with open('user.csv', 'a') as ff:
		#print('wrote user first name: ' + f)
		ff.write(a + ',' + f + ',' + l+ '\n')

with open('lc_last_names.txt') as lastin:
	names = lastin.readlines()
	for x in names:
		lastnames.append(x.capitalize().strip())

with open('first_names.txt') as firstin:
	names = firstin.readlines()
	for x in names:
		firstnames.append(x.capitalize().strip())



userfile = open('user.csv', 'w')

with open('phonebook.csv', 'w') as pbout:
	for user in range(1000, 9000):
		firstname = firstnames[random.randint(1, len(firstnames)-1)]
		lastname = lastnames[random.randint(1, len(lastnames)-1)]
		phoneno = getRandomPhoneNo()
		random.shuffle(allcodes)
		acctno = str(user) + allcodes[user]
		planid = random.randint(1, 8)
		sbid = user
		writeuser(acctno, firstname, lastname)
		
		pbout.write(str(sbid) + ',' + phoneno + ',' + acctno  + ',' + str(planid) + '\n')








