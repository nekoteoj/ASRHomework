template = [int(x) for x in input().split()]
test = [int(x) for x in input().split()]
constraint = int(input())

dp = [[0]*len(test) for i in range(len(template))]

for i in range(len(template)):
    for j in range(len(test)):
        if i - j >= constraint or j - i >= constraint:
            dp[i][j] = 2e9
            continue
        dist = int(abs(template[i] - test[j]))
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