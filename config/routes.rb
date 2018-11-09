Rails.application.routes.draw do
  resources :taskas
  resources :expenses, only:[:create,:destroy,:update,:edit]
  resources :classrooms, only:[:show]
  resources :kids, only:[:create,:destroy,:update,:edit]
  resources :payments, only:[:create,:destroy]
  resources :teachers, only:[:show]
  #resources :taska_teachers, only:[:create,:destroy]
  devise_for :parents
  devise_for :teachers
  devise_for :admins
	root 'welcomes#index'
  # For dtails on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #ADMINS
  get 'admin_index', to: 'admins#index'
  get 'webarch', to: 'admins#webarch'
  get 'webarchv2', to: 'admins#webarchv2'

  #TEACHERS
  get 'teacher_index', to: 'teachers#index'
  get '/taska/:id/search_teacher', to: 'teachers#search', as: 'search_teacher'
  get '/taska/:id/find_teacher', to: 'teachers#find', as: 'find_teacher'
  #PARENTS
  get 'parent_index', to: 'parents#index', as: 'parent_index'
  get '/parent/:id/view_receipt', to: 'parents#view_receipt', as: 'view_receipt'
  get '/parent/:id/individual_bill', to: 'parents#individual_bill', as: 'parents_individual_bill'
  get '/parent/:id/pay_bill', to: 'parents#parents_pay_bill', as: 'parents_pay_bill'
  get '/parent/:id/feedback', to: 'parents#parents_feedback', as: 'parents_feedback'
  #TASKAS
  get '/taska/:id/teachers', to: 'taskas#taskateachers', as: 'taskateachers'
  get '/taska/:id/classroom', to: 'taskas#classrooms_index', as: 'classroom_index'
  get '/taska/:id/children', to: 'taskas#children_index', as: 'children_index'
  #EXPENSES
  get '/taska/:id/expenses_search', to: 'expenses#search', as: 'search_expense'
  get '/taska/:id/expenses', to: 'expenses#my_expenses', as: 'my_expenses'
  get '/taska/:id/expenses/new', to: 'expenses#new', as: 'new_expense'
  get '/taska/:id/expenses/month_expense', to: 'expenses#month_expense', as: 'month_expense'
  #KIDS
  get '/parent/:id/kids/new', to: 'kids#new', as: 'new_kid'
  get '/classroom/:id/search_kid', to: 'kids#search', as: 'search_kid'
  get '/classroom/:id/find_kid', to: 'kids#find', as: 'find_kid'
  get 'add_classroom', to: 'kids#add_classroom'
  get 'remove_classroom', to: 'kids#remove_classroom'
  #TASKA_TEACHERS
  post '/taska/:id/add_teacher', to: 'taska_teachers#create', as: 'add_teacher'
  delete '/taska/:id/delete_teacher', to: 'taska_teachers#destroy', as: 'delete_teacher'
  #CLASSROOMS
  get '/classroom/:id/teachers', to: 'classrooms#taskateachers_classroom', as: 'list_teacher_classroom'
  #TEACHERS_CLASSROOMS
  post '/classrooms/:id/add_teachers', to: 'teachers_classrooms#create', as: 'add_teacher_classroom'
  delete '/classrooms/:id/delete_teachers', to: 'teachers_classrooms#destroy', as: 'delete_teacher_classroom'
  #payments
  get '/taska/:id/payment_index', to: 'payments#index', as: 'payment_index'
  get '/taska/:id/create_collection', to: 'payments#create_collection', as: 'create_collection'
  #get '/taska/:id/create_bill', to: 'payments#create_bill', as: 'create_bill'
  get '/taska/:id/search_bill', to: 'payments#search_bill', as: 'search_bill'
  get '/taska/:id/new_bill', to: 'payments#new', as: 'new_bill'
  get '/taska/:id/view_bill', to: 'payments#view_bill', as: 'view_bill'
  get '/payments/update', to: 'payments#update', as: 'payment_update'



  
end
