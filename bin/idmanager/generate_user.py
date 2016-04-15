import random
import string

'''
`emp_pidn` varchar(7) NOT NULL COMMENT 'system employee number',
  `emp_id` varchar(8) NOT NULL COMMENT 'net login',
  `emp_fname` varchar(32) NOT NULL COMMENT 'first name',
  `emp_lname` int(32) NOT NULL COMMENT 'last name',
  `emp_type` varchar(1) NOT NULL,
  `emp_status` varchar(1) NOT NULL,
  `emp_activity_date` date DEFAULT NULL,
'''

def id_generator(size = 7, chars=string.digits):
   ''' Return a string with the specified size parameter '''
   return ''.join(random.choice(chars) for x in range(size))


def get_existing_entries(dbfile):
   ''' Return a list data structure of existing entries contained in the dbfile '''
   existing = []
   with open(dbfile, 'r') as dfile:
      for x in dfile.readlines():
         existing.append(x.strip())
   return existing


def main():
   used_data_file_name = 'existing_entries.dat'
   all_entries = get_existing_entries(used_data_file_name)
    
   pidn = id_generator()
   if pidn not in all_entries:
      print(pidn)
      with open(used_data_file_name, 'a') as fout:
         fout.write(pidn + '\n')
   else:
      print("Wow you had a collision! Please run script again.")

if __name__ == '__main__':
   main() 


