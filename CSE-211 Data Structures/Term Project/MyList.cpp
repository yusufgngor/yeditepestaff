#include "MyList.h"

Mylist::Mylist(string name, int age) {
	headbyname = headbyage = new Node(name, age);
}

void Mylist::add(string name, int age) {
	Node* temp = new Node(name, age);
	addToAgeList(temp);
	addToNameList(temp);
}
bool Mylist::remove(string name) {
	Node* temp = Find(name);
	if (temp != nullptr)
	{
		removeFromAgeList(temp);
		removeFromNameList(temp);
		delete temp;
		return true;
	}
	cout << name << " does not exist " << endl;
	return false;
}
void Mylist::update(string name, int age) {
	Node* temp = Find(name);
	if (temp == nullptr)
	{
		cout << "no person could be found name is " << name << endl;
		return;
	}
	removeFromAgeList(temp);
	temp->age = age;
	addToAgeList(temp);
}
void Mylist::printByAge() {

	cout << "---------According To Age----------" << endl;
	cout << "|-Age-|  " << "\t" << "|-Name-|" << endl;

	for (Node* temp = headbyage; temp != nullptr; temp = temp->nextage)
	{
		cout << temp->age << "\t\t" << temp->name << endl;
	}
	cout << "---------end of list by age----------" << endl;
}
void Mylist::printByName() {
	cout << "---------According To Name----------" << endl;
	cout << "|-Name-|" << "\t" << "|-Age-|" << endl;

	for (Node* temp = headbyname; temp != nullptr; temp = temp->nextname)
	{
		cout << temp->name << "\t\t" << temp->age << endl;
	}
	cout << "---------end of list by name----------" << endl;
}
void Mylist::loadFile(string filename) {

	fstream newfile;
	newfile.open(filename, ios::in);
	if (newfile.is_open()) {
		string str;
		while (getline(newfile, str)) {

			string name;
			int age;
			istringstream ss(str);
			ss >> name;
			ss >> age;
			if (name == "" || age == 0)
			{
				continue;
			}
			add(name, age);

		}
		newfile.close();
	}

}
void Mylist::saveToFileByAge(string filename) {
	ofstream myfile(filename);
	if (myfile.is_open())
	{
		for (Node* tmp = headbyage; tmp != nullptr; tmp = tmp->nextage)
			myfile << tmp->name << " " << tmp->age << endl;
		myfile.close();
	}
}
void Mylist::saveToFileByName(string filename) {

	ofstream myfile(filename);
	if (myfile.is_open())
	{
		for (Node* tmp = headbyname; tmp != nullptr; tmp = tmp->nextname)
			myfile << tmp->name << " " << tmp->age << endl;
		myfile.close();
	}
}
void Mylist::addToAgeList(Node* temp) {
	if (headbyage == nullptr)
	{
		headbyage = temp;
		return;
	}

	if (headbyage->age >= temp->age)
	{
		temp->nextage = headbyage;
		headbyage = temp;
		return;
	}

	Node* iter;
	for (iter = headbyage; iter->nextage != nullptr && iter->nextage->age <= temp->age; iter = iter->nextage);
	temp->nextage = iter->nextage;
	iter->nextage = temp;
}
void Mylist::addToNameList(Node* temp) {

	if (headbyname == nullptr)
	{
		headbyname = temp;
		return;
	}

	if (isLess(temp->name, headbyname->name))
	{
		temp->nextname = headbyname;
		headbyname = temp;
		return;
	}

	Node* iter = headbyname;
	for (; iter->nextname != nullptr && isLess(iter->nextname->name, temp->name); iter = iter->nextname);

	temp->nextname = iter->nextname;
	iter->nextname = temp;


}
void Mylist::removeFromAgeList(Node* node) {
	if (headbyage == node)
		headbyage = headbyage->nextage;
	else
		for (Node* iter = headbyage; iter != nullptr; iter = iter->nextage)
			if (iter->nextage == node)
				iter->nextage = iter->nextage->nextage;

}
void Mylist::removeFromNameList(Node* node) {
	if (headbyname == node)
		headbyname = headbyname->nextname;
	else
		for (Node* iter = headbyname; iter != nullptr; iter = iter->nextname)
			if (iter->nextname == node)
				iter->nextname = iter->nextname->nextname;
}
bool Mylist::isLess(string& name1, string& name2) const {
	int size = name1.size() > name2.size() ? name2.size() : name1.size();
	for (int i = 0; i < size; i++)
	{
		if (name1[i] < name2[i])
			return true;
		else if (name1[i] > name2[i])
		{
			return false;
		}
	}
	return false;

}
Node* Mylist::Find(string& name) const {
	for (Node* iter = headbyname; iter != nullptr; iter = iter->nextname)
		if (iter->name == name)
			return iter;
	return nullptr;

}

