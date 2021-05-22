import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
        ),
        body: TodoList(),
        // body: TodoScreen(
        //   todos: List.generate(20, (index) => Todo(
        //     'Todo$index',
        //     'A description of what needs to be done for Todo $index',
        //
        //   ),),
        //
        // ),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoList=[];

  void _createTodo(){
    setState(() {
      int index = _todoList.length;
      _todoList.add('Item: $index');
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index<_todoList.length) {
          return _buildTodoItem(_todoList[index]);
        }
      },
    );
  }
  Widget _buildTodoItem(String text){
    return  ListTile(
      title: Text(text),
    );
  }

  void _addItem(String text){
    if(text.length>0){
      setState(() {
        _todoList.add(text);
      });

    }
  }

  void _pushAddTodoScreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context){
        return new Scaffold(
          appBar: AppBar(
            title: Text('Add Item'),
          ),
          body: Center(
            child:TextField(
              autofocus: true,
              onSubmitted: (val){
                //_todoList.add(val);
                _addItem(val);
                Navigator.pop(context);
              },
            )
          ),
        );
      })
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}



class TodoScreen extends StatelessWidget {
  final List<Todo> todos;
  const TodoScreen({Key key,  this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context,index){
         return ListTile(
            title: Text(todos[index].title),
           onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>DetailedScreen(
                    todo: todos[index],
                  ),
                ),
              );
           },
          );
        }
    );
  }
}

class DetailedScreen extends StatelessWidget {
  final Todo todo;
  const DetailedScreen({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Text(
          todo.description,
        ),
      ),
    );
  }
}






class Todo{
  final String title;
  final String description;

  Todo(this.title, this.description);
}
