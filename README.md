# Root Pages
Root Pages is a collection of quick and easy-to-reference tutorials, examples, and guides primarily for Linux and other UNIX-like systems. The main goal of this project is to provide an expanded alternative to "info" and/or "man" pages. 

## Usage
All Root Pages are writtin in the markdown language. Many users will likely want these files to be compiled into HTML for easier and prettier navigation. These can easily be converted with the help of Python's Markdown library. 
```
# pip install markdown
# python -m markdown README.md > README.html
# elinks README.html
```

## Development
Root Pages is a rolling release. As new information is commited, it is shortly pushed into master after a quick review for technical writing standards and correct citation usage. These documents are currently in English but translations are always welcome!

A few quick notes about technical documentation:
* Everything should be written in the 3rd person.
* Sentences should be easy-to-read and quick to the point.
* Chicago style citation to sources is REQUIRED.
  * If assistance is requried with the syntax of new citations, check out [Citation Machine](http://www.citationmachine.net/chicago).

## Legal
### License - GPLv3
Root Pages and all of its content is provided under the GPLv3. Why? We believe that all information should be free information. Knowledge is power and we strongly believe that everyone deserves to learn and grow to their fullest potentional.

### Plagerism
Root Pages strives to provide proper citation to the original authors to give credit where due. If there are any reports of plagerism, please send an e-mail to ekultails@gmail.com and I will ensure it gets addressed accordingly.
