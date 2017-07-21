package il.ac.hit.mvcdemo.model;

/**
 * Class for the items of the to do list
 * @author Sanad Satel , Melak Firdo
 * @since 2017
 */
public class Items
{
    private int id;
    private String itemName;
    private String description;
    private int userId;

    /**
     * default constructor
     */
    public Items(){}

    /**
     *  constructor that initializes the user data member in case one of the values  is null throw null pointer exception
     * @param itemName
     * @param description
     * @param userId
     * @throws NullPointerException
     * @throws IllegalArgumentException
     */
    public Items(String itemName, String description, int userId) throws  NullPointerException ,IllegalArgumentException
    {
        this();
        this.setItemName(itemName);
        this.setDescription(description);
        this.setUserId(userId);
    }

    /**
     * gets the item id
     * @return item id
     */
    public int getId() {
        return id;
    }

    /**
     * set task Id in case value is null throw null pointer exception in
     * case negative number throws illegal  argument exception
     * @param id
     * @throws NullPointerException
     * @throws IllegalArgumentException
     */
    public void setId(int id)throws NullPointerException ,IllegalArgumentException {
        try{
            if (id>0){ this.id= id;}
           else{throw new IllegalArgumentException
                    ("Value must be non-negative");}
        }
        catch (NullPointerException ex){ex.printStackTrace();}
        catch (IllegalArgumentException ex){ex.printStackTrace();}
    }

    /**
     * gets the name of the item
     * @return the name of the item
     */
    public String getItemName() {return itemName;}

    /**
     * set user item name in case value is null throw null pointer exception
     * @param itemName
     * @throws NullPointerException
     */
    public void setItemName(String itemName) throws NullPointerException {
        try {
            this.itemName = itemName;
        } catch (NullPointerException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * gets description about the item
     * @return string description about the item
     */
    public String getDescription() {
        return description;
    }

    /**
     * set user item description in case value is null throw null pointer exception
     * @param description
     * @throws NullPointerException
     */
    public void setDescription(String description)throws NullPointerException {
        try {
            this.description = description;
        } catch (NullPointerException ex) {
            ex.printStackTrace();
        }
    }
    /**
     * gets the id of the user that belongs to the item
     * @return user id
     */
    public int getUserId() {
        return userId;
    }


    /**
     * set task userId in case value is null throw null pointer exception in
     * case negative number throws illegal  argument exception
     * @param userId
     * @throws NullPointerException
     * @throws IllegalArgumentException
     */
    public void setUserId(int userId)throws NullPointerException ,IllegalArgumentException {
        try{
            if (userId>0){ this.userId= userId;}
            else{throw new IllegalArgumentException
                    ("value must be a non-negative");}

        }
        catch (NullPointerException ex){ex.printStackTrace();}
        catch (IllegalArgumentException ex){ex.printStackTrace();}
    }

    /**
     * implementation of the method toString
     * @return string that includes the item properties
     */
    @Override
    public String toString()
    {
        return ("item id: " + this.id + " item name: " + this.itemName +
                " description: " + this.description);
    }
}
