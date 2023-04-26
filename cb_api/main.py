from flask import escape, Flask, request, jsonify, json
import firebase_admin
from firebase_admin import firestore, credentials, initialize_app
import datetime
import pytz
from google.cloud.firestore_v1 import SERVER_TIMESTAMP
import smtplib
from email.message import EmailMessage
from flask_cors import CORS


cred = credentials.Certificate("key.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
app = Flask(__name__)
CORS(app)

# Entities
students = db.collection("students")
posts = db.collection("posts")
mail_ref = db.collection("mail")


#time function
def get_time():
     # Get the current time in UTC timezone
    now_utc = datetime.datetime.now(tz=pytz.utc)

    # Convert the UTC time to GMT timezone
    tz = pytz.timezone('GMT')
    now_gmt = now_utc.astimezone(tz)
    date_string = now_gmt.strftime('%Y-%m-%d %H:%M:%S')
    return date_string

# create profile
@app.route("/profile", methods=["POST"])
def create_profile():

    data = json.loads(request.data)

    if not data:
        return jsonify({"Error": "Oops no data passed"}),404

    email = data["email"]

    # check if student is already in the database
    stud_exists = students.document(email).get().exists
    if stud_exists:
        return jsonify({"Error": "Student already exists"}), 409
    data["user_posts"] = []
    students.document(email).set(data)
    return jsonify(data), 201

@app.route("/profile", methods=["PATCH"])
def edit_profile():
    record = json.loads(request.data)
    email = record["email"]

    # check if user exists
    student_ref = db.collection("students").document(email)
    student_doc = student_ref.get()

    if not student_doc.exists:
        return jsonify({"Message": "Student does not exist"}), 404

    # update the voter details
    update_dict = {}
    if "major" in record:
        update_dict["major"] = record["major"]
    if "year_group" in record:
        update_dict["year_group"] = record["year_group"]
    if "best_food" in record:
        update_dict["best_food"] = record["best_food"]
    if "best_movie" in record:
        update_dict["best_movie"] = record["best_movie"]
    if "campus_residence" in record:
        update_dict["campus_residence"] = record["campus_residence"]
    if "DOB" in record:
        update_dict["DOB"] = record["DOB"]
    if "gender" in record:
        update_dict["gender"] = record["gender"]
   
    


    student_ref.update(update_dict)

    # retrieve and return the updated voter data
    student_doc = db.collection("students").document(email).get()
    student_data = student_doc.to_dict()
    return jsonify(student_data)



@app.route("/profile", methods=["GET"])
def view_profile():
    # print('This is my a GET request')
    # record = json.loads(request.data)
    email = request.args.get('email')
    # email = record["email"]
    student_ref = db.collection("students").document(email)
    student_doc = student_ref.get()
    if not student_doc.exists:
        return jsonify({"Message": "Student does not exist"}), 404

    student_data = student_doc.to_dict()

    return jsonify(student_data), 200

#function for sending mails
def sendEmails(email):
    all_emails = db.collection("students")
    email_list = []
    student_mail = email
    for student_email in all_emails.get():
        student_email = student_email.to_dict()["email"]
        email_list.append(student_email)
        # student_mail = email
  
    student_details = students.document(student_mail).get().to_dict()
    student_fullname = student_details["first_name"] + " "+ student_details["last_name"]
    for email in email_list:
        
        new_email = mail_ref.document()
        new_email.set(
            {
             "to":email,
             "message":{
                "subject": "New post by " + student_fullname + "!",
                "text":  "Login into CampusBuzz to see the post" 
             }
            }
        )

@app.route("/create_post", methods=["POST"])
def create_post():
    # if not request.data:
    #     return jsonify({"Error": "Oops no data passed"}),400
    post = json.loads(request.data)
    email = post["email"]
    
    

    # check if email is in the database
    # student_ref = db.collection("students").stream()
    stud_exists = students.document(email).get().exists
    # post_ref = posts.document(get_time())
    if stud_exists:
        timestamp = datetime.datetime.now()
        timestamp_str = timestamp.strftime('%Y-%m-%d %H:%M:%M:%S')
        
        post_ref = posts.document(timestamp_str)
        post_obj={
            "email": email,
            "post": post["post"],
            "time_posted": timestamp_str
        }

        post_ref.set(post_obj)
        print(timestamp_str)

        # posts.document(get_time()).set(request.json)
        #create new post
        # post_ref.update({"time_posted": timestamp_str})
        
        #update the list of all post by a particular student
        student_posts = students.document(email).get().to_dict()['user_posts']
        student_posts.append(timestamp_str)
        students.document(email).update({'user_posts':student_posts})

        
        #sending mails to students in the database.
        sendEmails(email)
        return jsonify(request.json), 201
    return jsonify({"Error": "There is no student with this email"}), 404



@app.route("/feed", methods=["GET"])
def get_feed():
    ordered_posts = posts.order_by("time_posted", direction=firestore.Query.DESCENDING).get()
    post_list = []
    for post in ordered_posts:
        post_list.append(post.to_dict())
    json_post_list = json.dumps(post_list, indent=5)
    return json_post_list



@app.route("/login", methods=["POST"])
def login_profile():
    # get login credentials from form data
    log_cred = json.loads(request.data)
    login_email = log_cred['email']
    password = log_cred['password']

    # create empty doc object for profile
    profile = db.collection('students').document(login_email)
    
    # get the profile info for this id
    profile_doc = profile.get()
    
    
    
    if profile_doc.exists:
        first_name = profile_doc.to_dict()['first_name']
        last_name = profile_doc.to_dict()['last_name']
        DOB = profile_doc.to_dict()['DOB']
        best_food = profile_doc.to_dict()['best_food']
        best_movie = profile_doc.to_dict()['best_movie']
        campus_residence = profile_doc.to_dict()['campus_residence']
        major = profile_doc.to_dict()['major']
        student_id = profile_doc.to_dict()['student_id']
        year_group = profile_doc.to_dict()['year_group']
        gender = profile_doc.to_dict()['gender']

        if profile_doc.to_dict()['password'] == password:
            print('logged student '+ login_email + ' in successfully')
            
            return jsonify({'success': True, 'message': 'logged student '+ login_email + ' in successfully', 'email': login_email, 
            'first_name': first_name, 'last_name':last_name, 'DOB':DOB,'best_food':
            best_food, 'best_movie':best_movie, 'campus_residence': campus_residence, 'major':major,'student_id': student_id,'year_group':year_group, 'gender':gender}),200
        else:
            print('incorrect id or password')
            
            return jsonify({'success': False, 'message': 'Incorrect id or password'}), 404

    else:
        return jsonify({'success': False, 'message': 'Incorrect id or password'})

# app.run(debug=True)
