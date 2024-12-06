#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

// The maximum number of valid points the user can input
#define VALID_POINTS 1000

// Distance between two points
double distance(double x_1, double y_1, double x_2, double y_2){
    return sqrt(pow((x_1 - x_2), 2) + pow((y_1 - y_2),2));
}

int main(int argc, char **argv){
    // The coordinates of the points stored in two arrays
    // This array stores the x-coordinates of the points
    double x_points[VALID_POINTS];
    // This array stores the y-coordinates of the points
    double y_points[VALID_POINTS];
    // The number of valid point the program reads
    int number_of_points = 0;
    // A loop which allows the user to input a maximum of 1000 points
    while(number_of_points < VALID_POINTS){
        char points[100];
            // Read the entire line into the buffer
            if (fgets(points, sizeof(points), stdin) == NULL) {
                break;
            }
            // The coordinates stored in x and y.
            double x, y;
            if (sscanf(points, "%lf, %lf", &x, &y) == 2) {
                x_points[number_of_points] = x;
                y_points[number_of_points] = y;
                // Counts the number of points read by the program
                number_of_points += 1;
            } else if (points[0] == '\n') {
                // Stopping user input if its a blank line.
                break;
            } else {
                // Invalid input. 
            }
        }
    // Prints the valid points.
    printf("read %d points\n", number_of_points);
    // Finding the three storeIndex points 
    
    // If theres less than three points, there is no triangle
    if(number_of_points == 0){
        printf("This is not a triangle\n");
        exit(0);
    }
    else if(number_of_points < 3){
        for(int i = 0; i < number_of_points; i++){
            printf("%.2lf, %.2lf\n", x_points[i], y_points[i]);
        }
        printf("This is not a triangle\n");
    } else {
        /* First I initialise an array of size 4 which stores the indices of the three storeIndex points and 
        the sum of the distances between them.*/
        int storeIndex[4] = {-1, -1, -1, -1};
        // This array stores the distances between the two points
        double distanceBetweenPoints[VALID_POINTS][VALID_POINTS];
        // Calculate distances between all pairs of points
        for (int i = 0; i < number_of_points; i++) {
            for (int j = i + 1; j < number_of_points; j++) {
                // Finding the distance between the two points whose indices are i and j
                distanceBetweenPoints[i][j] = distance(x_points[i], y_points[i], x_points[j], y_points[j]);
                // This is storing the same distance between j and i 
                distanceBetweenPoints[j][i] = distanceBetweenPoints[i][j];
            }
        }

        // The three storeIndex points 
        /* The first for loop doesnt iterate the last two points because that makes sure that we have 
        enough points to make a triangle */
        for (int i = 0; i < number_of_points - 2; i++) {
            // The second loop starts from the second element because it will have duplicates otherwise
            for (int j = i + 1; j < number_of_points - 1; j++) {
                // // This starts from j + 1 to avoid duplicates
                for (int k = j + 1; k < number_of_points; k++) {
                    double sum = distanceBetweenPoints[i][j] + distanceBetweenPoints[j][k] + distanceBetweenPoints[k][i];
                    // storeIndex[0] will store the sum of the distances between, and we want the minimum
                    // We initialise the first to -1 so we check for that as well
                    if (storeIndex[0] == -1 || sum < storeIndex[0]) {
                        storeIndex[0] = sum;
                        storeIndex[1] = i;
                        storeIndex[2] = j;
                        storeIndex[3] = k;
                    }
                }
            }
        }

        // The closest points are 
        printf("%.2lf, %.2lf\n", x_points[storeIndex[1]], y_points[storeIndex[1]]);
        printf("%.2lf, %.2lf\n", x_points[storeIndex[2]], y_points[storeIndex[2]]);
        printf("%.2lf, %.2lf\n", x_points[storeIndex[3]], y_points[storeIndex[3]]);

        // The area for three points is 
        double area = 0.5 * fabs(x_points[storeIndex[1]] * (y_points[storeIndex[2]] - y_points[storeIndex[3]])
                                 + x_points[storeIndex[2]] * (y_points[storeIndex[3]] - y_points[storeIndex[1]])
                                 + x_points[storeIndex[3]] * (y_points[storeIndex[1]] - y_points[storeIndex[2]]));

        // Check if it forms a triangle
        if (area > 0.001) {
            printf("This is a triangle\n");
        } else {
            printf("This is not a triangle\n");
        }
    return 0;
    }
}



