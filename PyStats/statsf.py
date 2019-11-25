def max(data):
    maxVal = 0
    for i in data:
        if maxVal < i:
            maxVal = i
    return maxVal

def min(data):
    minVal = -1
    for i in data:
        if minVal == -1 or minVal > i:
            minVal = i
    return minVal

def mean(data):
    sum = 0
    for i in data:
        sum += i
    return sum / len(data)
def variance(data):
    avg = mean(data)
    sum = 0
    for i in data:
        sum += (i - avg) ** 2

    return sum / len(data);

def std_deviation(data):
    return variance(data) ** 0.5

data = [1,2,3,4,5,6,7,8,9]
print(mean(data))
print(range(min(data), max(data) + 1))
print(max(data))
print(min(data))
print(variance(data))
print(std_deviation(data))
