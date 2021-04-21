import React, {Component} from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {

  serverhosts = [ "http://localhost:8080", "" ]

  state = {
      name: "Hello internal!",
      host: "localhost"
  }

  componentDidMount() {
    for (var serverhost of this.serverhosts) {
      fetch(serverhost+'/hello')
        .then(res => res.json())
        .then((data) => {
          this.setState(data)
        })
        .catch(()=>{})
      }
  }

  render () {

    const { name, host } = this.state;

    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            {name} from {host}
          </p>
          <a
            className="App-link"
            href="https://move2kube.konveyor.io/"
            target="_blank"
            rel="noopener noreferrer"
          >
            Move2Kube
          </a>
        </header>
      </div>
    );
  }
}

export default App;
