var CustomHeader = React.createClass({
  render: function() {
    return (<h2 className="red">My Message to {this.props.name}{this.props.punctuation()}</h2>);
  }
});

var HelloWorld = React.createClass({
  getInitialState: function() {
    return {
      currentInput: "",
      name: "Brandon"
    };
  },
  punctuation: function() {
    return "!";
  },
  updateName: function() {
    this.setState({name: this.refs.name.value});
  },
  updateInput: function() {
    this.setState({currentInput: this.refs.name.value});
  },
  render: function() {
    return (
      <div>
      <CustomHeader name={this.state.name} punctuation={this.punctuation}/>
      Hello
      {this.state.currentInput.length > 0 ? " " + this.state.currentInput : ""}!
      <br/>
      <input type="text" ref="name" placeholder="Enter your name" onInput={this.updateInput}/>
      <br/>
      <button onClick={this.updateName}>Change the world!</button>
      </div>
      );
  }
});


ReactDOM.render(
  <HelloWorld name="Brandon" />,
  document.getElementById('container')
  );
