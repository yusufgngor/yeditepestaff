
#include <iostream>
#include "MyList.h"

using namespace std;


int main()
{

    Mylist list;
    list.loadFile("input.txt");

    list.printByName();
    list.printByAge();


    list.remove("deniz");
    list.remove("ismail");
    list.update("yusuf", 22);
    list.update("selami", 22);
    list.printByName();
    list.printByAge();
   
    list.saveToFileByAge("age.txt");
    list.saveToFileByName("name.txt");
}
