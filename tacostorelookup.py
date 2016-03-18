import os
def lookup():
        print('This tool will tell you BOH type')
        print('If tool comes back with no results,')
        print('then it is not eR or TACO site or store number is wrong.')
        print('\n' * 5)
        store = raw_input('Enter Store: ')
        searchfile = open("skynode.txt", "r")
        for line in searchfile:
                if store in line:
                        print line
        else:
                print "Maybe Sabretooth or KMAC?"
        os.system('pause')
        os.system('cls')
        searchfile.close()
lookup()
done = False 
while not done: 
    lookup()
input = raw_input("Start over? Y/N :") 
if input == "N": 
    done = True








