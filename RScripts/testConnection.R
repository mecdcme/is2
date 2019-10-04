library("RSclient")
c = RSconnect(host = "localhost", port = 6311)
RSclose(c)