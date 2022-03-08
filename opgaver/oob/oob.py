class per:
    def __init__(self, n , strin):
        self.n = n
        self.strin = strin
    def prin_n(self):
        for i in range(self.n):  
            print(self.strin)
ob_print = per(55 , "hej med dig")
ob_print.prin_n()

