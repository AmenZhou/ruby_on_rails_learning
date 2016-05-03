##### Basic

```js
class RobotBox extends React.Component {
  render() {
    return <div>Hello From React</div>;
  }
}

let target = document.getElementById('robot-app');

ReactDOM.render( <RobotBox />, target);
```

#####How to use js in the return

```js
example 1

class RobotTime extends React.Component {
  render() {
  	let pi = Math.PI;
    return (
      <div className='is-tasty-pie'  >
        The value of PI is approximately {pi}.
      </div>
    );
  }
}


example 2
class RobotItems extends React.Component {
  render() {
    const topics = ["React", "JSX", "JavaScript", "Programming"];
    return (
      <div>
        <h3>Topics I am interested in</h3>
        <ul>
          {topics.map( topic => <li>{topic}</li>)}  //double {} here
        </ul>
      </div>
    );
  }
}
```
