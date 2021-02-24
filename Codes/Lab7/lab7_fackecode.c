#include <stdio.h>
#include <string.h>

typedef struct companydetais
{
    /* data */
    //年份
    char year[5];
    //总收入
    int total;
    //雇员人数
    unsigned int emp_total;
    //平均收入
    int arpu;
}COMPNY_DETAILS;

int main() 
{
    //代表21年公司的21个年份
    char Years[21][4] = {"1975","1976","1977","1978","1979","1980","1981","1982","1983",
                       "1984","1985","1986","1987","1988","1989","1990","1991","1992",
                       "1993","1994","1995"};

    //代表21年公司总收入
    int Total[]={16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514,
                 34580,590827,803530,1183000,1843999,2759000,3753000,4649000,5937000};

    //代表21年公司雇员人数的21个word类型数据
    unsigned int Emp_total[]={3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,
                              11542,14430,15257,17800};


    //然后就是循环，把数据放入结构体
    COMPNY_DETAILS cmp_details[21];


    size_t count = 21;
    for (size_t i = 0; i < count; i++)
    {
        /* code */
        //printf("%s\n",Years[i]);
        memcpy(cmp_details[i].year,&Years[i][0],4);
        cmp_details[i].year[4] = '\0';
        cmp_details[i].total  = Total[i];
        cmp_details[i].emp_total = Emp_total[i];
        cmp_details[i].arpu = (cmp_details[i].total / cmp_details[i].emp_total);
       /*
        printf("------第%zu组数据-------\n",i);
        printf("年份:%s\n",cmp_details[i].year);
        printf("总收入:%d\n",cmp_details[i].total);
        printf("雇员人数:%d\n",cmp_details[i].emp_total);
        printf("人均收入:%d\n",cmp_details[i].arpu);
        printf("----------------------\n\n");
        */
    }

}

//将上述代码用汇编格式转换 便可。