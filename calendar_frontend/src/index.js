import React from 'react';
import ReactDOM from 'react-dom';
import 'bootstrap/dist/css/bootstrap.css';
import './stylesheets/index.css'
import './stylesheets/main.css'
// import App from './App';
import RoutedApp from './RoutedApp';
import * as serviceWorker from './serviceWorker';

ReactDOM.render(<React.StrictMode><RoutedApp /></React.StrictMode>, document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
