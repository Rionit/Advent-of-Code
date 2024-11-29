#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    int max = INT_MIN;
    int food, cur_calories;
    int ret = 0;
    while(ret != EOF){
        while((ret = scanf("%d", &food)) == 1){
            // printf("food: %d\n", food);
            cur_calories += food;
        }
        if(cur_calories > max){
            max = cur_calories;
        }
        cur_calories = 0;
        printf("new worker\n");
    }
    printf("%d\n", max);
    return 0;
}
