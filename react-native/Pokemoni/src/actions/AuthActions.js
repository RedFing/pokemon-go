import axios from 'axios';
import { AsyncStorage } from 'react-native';
import {
  EMAIL_CHANGED,
  PASSWORD_CHANGED,
  LOGIN_USER_SUCCESS,
  LOGIN_USER_FAIL,
  LOGIN_USER
} from './types';

export const emailChanged = (text) => {
  return {
    type: EMAIL_CHANGED,
    payload: text
  };
};

export const passwordChanged = (text) => {
  return {
    type: PASSWORD_CHANGED,
    payload: text
  };
};

export const loginUser = ({ email, password }) => {
  return (dispatch) => {
    dispatch({ type: LOGIN_USER });
    axios.post('http://192.168.0.11:3000/login_api', {
    unmLogin: email,
    passLogin: password
  })
    .then((body) => {
        if (body.data.status === 'OK') {
          const user = {
            token: body.data.token,
            email
          };
          loginUserSuccess(dispatch, user);
        } else {
          loginUserFail(dispatch);
        }
    }).catch(() => loginUserFail(dispatch));
  };
};

const loginUserFail = (dispatch) => {
  dispatch({ type: LOGIN_USER_FAIL });
};

const loginUserSuccess = (dispatch, user) => {
  console.log(user);
  AsyncStorage.setItem('user', JSON.stringify(user));
  dispatch({
    type: LOGIN_USER_SUCCESS,
    payload: user
  });
};
