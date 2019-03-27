from math import sqrt

template = [(1,-1), (3,3), (8,7), (4,-5), (5,4)]
test = [(2,0), (2,4), (4,2), (4,-4), (6,3)]

def cal_dist(x, y):
    return sqrt((x[0] - y[0])**2 + (x[1] - y[1])**2)

dp = [[0]*len(test) for i in range(len(template))]

for i in range(len(template)):
    for j in range(len(test)):
        dist = cal_dist(template[i], test[j])
        p1 = p2 = p3 = 2e9
        if i == 0 and j == 0:
            p1 = p2 = p3 = dist
        if i-1 >= 0 and j-1 >= 0:
            p1 = dp[i-1][j-1] + dist
        if i-2 >= 0 and j-1 >= 0:
            p2 = dp[i-2][j-1] + 2*dist
        if i-1 >= 0 and j-2 >= 0:
            p3 = dp[i-1][j-2] + dist
        dp[i][j] = min(p1, p2, p3)

for i in range(len(template)):
    for j in range(len(test)):
        if dp[i][j] >= 2e9:
            print('X', end=' ')
        else:
            print(dp[i][j], end=' ')
    print()

print(dp[len(template)-1][len(test)-1])