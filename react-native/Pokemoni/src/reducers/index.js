import { combineReducers } from 'redux';
import AuthReducer from './AuthReducer';
import PokemonReducer from './PokemonReducer';


export default combineReducers({
  auth: AuthReducer,
  pokemons: PokemonReducer
});
