# PixNyanNyan Backend API

This README would normally document whatever steps are necessary to get the
application up and running.

## Get started with Docker

Check out files in `deploy` folder for example docker-compose configuration.

## API Endpoints

Verb   | URI Pattern      | Controller#Action
------ | ---------------- | -----------------
GET    | /api/sign_in     | admin/sessions#new
POST   | /api/sign_in     | admin/sessions#create
DELETE | /api/sign_out    | admin/sessions#destroy
POST   | /api/posts       | api/posts#create
DELETE | /api/posts       | api/posts#destroy
GET    | /api/threads     | api/threads#index
GET    | /api/threads/:id | api/threads#show
GET    | /api/staffs      | api/staffs#index
POST   | /api/staffs      | api/staffs#create
PATCH  | /api/staffs/:id  | api/staffs#update
PUT    | /api/staffs/:id  | api/staffs#update
GET    | /api/config      | api/config#index
