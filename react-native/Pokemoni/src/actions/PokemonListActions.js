import axios from 'axios';
import { AsyncStorage } from 'react-native';
import {
  POKEMON_FETCH_SUCCESS,
  BASE_URL
} from './types';

export const pokemonFetch = () => {
  AsyncStorage.getItem('user', (err, value) => {
      if (err) console.log(err);
      if (value !== null) {
        const user = JSON.parse(value);
        const url = BASE_URL + '/showtable?rntoken=' + user.token;
        return (dispatch) => {
          axios.get(url)
            .then(response => {
               dispatch({ type: POKEMON_FETCH_SUCCESS, payload: response });
               console.log(response);
            })
            .catch(error => {
              console.log(error);
              // error obtaining pokemon list
            });
        };
      }
  });
};
