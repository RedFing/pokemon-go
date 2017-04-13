import React, { Component } from 'react';
import { Navigator } from 'react-native';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';

import ReduxThunk from 'redux-thunk';
import reducers from './reducers';
import LoginForm from './components/LoginForm';
import PokemonList from './components/PokemonList';
import TestComponent from './components/TestComponent';

class App extends Component {
  state = { globalToken: '' };
  render() {
    const store = createStore(reducers, {}, applyMiddleware(ReduxThunk));

    return (
      <Provider store={store}>
         <Navs />
      </Provider>
    );
  }
}

class Navs extends Component {

  navigatorRenderScene(route, navigator) {
    switch (route.id) {
      case 'login':
        return (<LoginForm navigator={navigator} />);
      case 'pokemonlist':
        return (<TestComponent navigator={navigator} />);
      default:
        return (<TestComponent navigator={navigator} />);
    }
  }
  render() {
    return (
        <Navigator
        initialRoute={{ id: 'login' }}
        renderScene={this.navigatorRenderScene}
        />
    );
  }
}


export default App;
