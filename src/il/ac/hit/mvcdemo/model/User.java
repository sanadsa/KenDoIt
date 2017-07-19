package il.ac.hit.mvcdemo.model;

import java.lang.NullPointerException;

/**
 * Class for the user
 * @author Sanad Satel , Melak Firdo
 * @since 2017
 */
public class User
{
    private int userId;
    private String userFirstName;
    private String userLastName;
    private String userPassword;
    private String email;

    /**
     * constructor that initializes the user data member in case one of the values  is null throw null pointer exception
     * @param userFirstName
     * @param userLastName
     * @param userPassword
     * @param userEmail
     * @throws NullPointerException
     */
    public User(String userFirstName, String userLastName, String userPassword, String userEmail)throws NullPointerException {
        this();
        try
        {
            this.setUserFirstName(userFirstName);
            this.setUserLastName(userLastName);
            this.setEmail(userEmail);
            this.setUserPassword(userPassword);
        }
        catch (NullPointerException ex)
        {
            ex.printStackTrace();
        }

    }

    /**
     * default constructor
     */
    public User(){}

    /**
     * gets user id
     * @return user id
     */
    public int getUserId() {
        return userId;
    }


    /**
     * set userId in case value is null throw null pointer exception
     *  case negative number throws illegal  argument exception
     * @param userId
     * @throws NullPointerException
     * @throws IllegalArgumentException
     */
    public void setUserId(int userId) throws NullPointerException, IllegalArgumentException {
        try{
            if (userId>0){ this.userId= userId;}
            else{throw new IllegalArgumentException
                    ("value must be non-negative");}

        }
        catch (NullPointerException ex){ex.printStackTrace();}
        catch (IllegalArgumentException ex){ex.printStackTrace();}
    }

    /**
     * get first name
     * @return String firstName
     */
    public String getUserFirstName() {
        return userFirstName;
    }

    /**
     * set user first name in case value is null throw null pointer exception
     * @param userFirstName
     * @throws NullPointerException
     */
    public void setUserFirstName(String userFirstName) throws NullPointerException {
        try{this.userFirstName= userFirstName;}catch (NullPointerException ex){ex.printStackTrace();}
    }

    /**
     * gets the last name
     * @return String last name
     */
    public String getUserLastName() {return userLastName;}

    /**
     * set last name in case value is null throw null pointer exception
     * @param userLastName
     * @throws NullPointerException
     */
    public void setUserLastName(String userLastName)throws NullPointerException{
            try{this.userLastName= userLastName;}catch (NullPointerException ex){ex.printStackTrace();}}

    /**
     * gets user email
     * @return the password of the user
     */
    public String getEmail() {
        return email;
    }

    /**
     * set last email in case value is null throw null pointer exception
     * @param email
     * @throws NullPointerException
     */
    public void setEmail(String email)throws NullPointerException{
        try{this.email= email;}catch (NullPointerException ex){ex.printStackTrace();}}

    /**
     * gets user password
     * @return the password of the user
     */
    public String getUserPassword() {
        return userPassword;
    }

    /**
     * set password in case value is null throw null pointer exception
     * @param userPassword
     * @throws NullPointerException
     */
    public void setUserPassword(String userPassword)throws NullPointerException{
        try{this.userPassword= userPassword;}catch (NullPointerException ex){ex.printStackTrace();}}

    /**
     *implements toString method
     * @return string of the user properties
     */
    @Override
    public String toString()
    {
        return ("user id: " + this.userId + " name: " + this.userFirstName + " password: " + this.userPassword);
    }
}

