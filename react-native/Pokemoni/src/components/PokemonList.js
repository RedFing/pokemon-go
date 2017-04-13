import _ from 'lodash';
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { ListView, Text } from 'react-native';
import { pokemonFetch } from '../actions';
import ListItem from './ListItem';

class PokemonList extends Component {
  componentWillMount() {
    console.log('testsss');
    this.props.pokemonFetch();

    this.createDataSource(this.props);
  }

  componentWillReceiveProps(nextProps) {
    // nextProps are the next set of props that this component
    // will be rendered with
    // this.props is still the old set of props

    this.createDataSource(nextProps);
  }

  createDataSource({ pokemons }) {
    const ds = new ListView.DataSource({
      rowHasChanged: (r1, r2) => r1 !== r2
    });

    this.dataSource = ds.cloneWithRows(pokemons);
  }

  renderRow(pokemon) {
    return <ListItem pokemon={pokemon} />;
  }

  render() {
    return (
      <ListView
        enableEmptySections
       dataSource={this.dataSource}
        renderRow={this.renderRow}
      />
    );
  }
}

const mapStateToProps = state => {
  const pokemons = _.map(state.pokemons, (val, uid) => {
    return { ...val, uid };
  });

  return { pokemons };
};

export default connect(mapStateToProps, { pokemonFetch })(PokemonList);
