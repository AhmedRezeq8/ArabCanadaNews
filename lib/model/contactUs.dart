class ContactUs {
   String name;
   String email;
   String subject;
   String text;

  ContactUs(this.name, this.email, this.subject, this.text);
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "subject": subject,
        "text": text,
      
    };
}
