#pragma once

#include <iostream>
#include <fstream>
#include <sstream>


using namespace std;

struct Node
{
	string name;
	int age;
	Node* nextage;
	Node* nextname;
	Node(const string& name = "", const int& age = 0, Node* nextage = nullptr, Node* nextname = nullptr) {
		this->name = name;
		this->age = age;
		this->nextage = nextage;
		this->nextname = nextname;
	}

};


class Mylist
{
public:
	Mylist() :headbyage(nullptr), headbyname(nullptr) {}
	Mylist(string,int);
	void add(string, int);
	bool remove(string);
	void update(string, int);
	void printByAge();
	void printByName();
	void loadFile(string);
	void saveToFileByAge(string);
	void saveToFileByName(string);
private:
	void addToNameList(Node*);
	void addToAgeList(Node*);
	void removeFromNameList(Node*);
	void removeFromAgeList(Node*);
	bool isLess(string&, string&) const;
	Node* Find(string&) const;
	Node* headbyname;
	Node* headbyage;
};

