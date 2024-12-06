import sys
import argparse
import random
import math


def distance(first_point, second_point):
    return math.sqrt((first_point[0] - second_point[0]) ** 2 + (first_point[1] - second_point[1]) ** 2)

def generate(N, mindist, rseed):

    if N < 0:
        print("N less than zero", file=sys.stderr)
        sys.exit(-1)

    if N > 10000/ (math.pi * mindist**2):
        print("point saturation", file=sys.stderr)
        sys.exit(-3)

    if mindist < 0 or mindist > 10:
        print("mindist outside range", file=sys.stderr)
        sys.exit(-2)

    if rseed is not None:
        random.seed(rseed)

    # The generated points stored in this array
    generated_points = []
    while len(generated_points) < N:
        x = random.uniform(-50, 50)
        y = random.uniform(-50, 50)
        new_point = (round(x, 2), round(y, 2))

        valid = True
        for existing_point in generated_points:
            if distance(new_point, existing_point) < mindist:
                valid = False
                break
        if valid:
            generated_points.append(new_point)
            print("{:.2f}, {:.2f}".format(new_point[0], new_point[1]))

    return generated_points
    

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = "input")
    parser.add_argument('-N', type = int, nargs='?', help = 'number of valid points')
    parser.add_argument('-mindist', type = float, help = 'distance between the two points')
    parser.add_argument('-rseed', type = int, help = 'random')
    
    try:
        args = parser.parse_args()
    except argparse.ArgumentError:
        sys.exit(-4)

    if args.N is None:
        sys.exit(-4)
    elif args.mindist is None:
        sys.exit(-4)
    else:
        generate(args.N, args.mindist, args.rseed)





