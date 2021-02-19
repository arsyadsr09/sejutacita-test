
const BASE_API = "https://api.github.com";
const API_VERSION = "application/vnd.github.v3+json";

const HEADER = {"Accept": API_VERSION, "Content-Type": 'application/json'};

const AUTHORIZATION_DATA = {
  'client_id': '06ad2d70e0a970cf2bcf',
  'client_secret': '3aa11e6c6dad8e56b52179412331f6f6eb22d24e',
  'callback': 'https://bumi-kopi.firebaseapp.com/__/auth/handler',
  'scopes': [
    "user",
    "repo",
    "gist",
    "notifications",
    "write:discussion",
    "user:follow"
  ],
};
