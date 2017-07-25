package il.ac.hit.mvcdemo.controller;

import com.sun.xml.internal.bind.v2.TODO;
import il.ac.hit.mvcdemo.model.HibernateToDoListDAO;
import il.ac.hit.mvcdemo.model.Items;
import il.ac.hit.mvcdemo.model.ToDoListException;
import il.ac.hit.mvcdemo.model.User;
import org.hibernate.test.cache.Item;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.StringTokenizer;

/**
 * Servlet implementation class Router
 */
@WebServlet(value = "/Router")
public class Router extends HttpServlet {
    private static final long serialVersionUID = 1L;
    boolean isSuccess=false;
    private String linkTo;
    //creating the instance for the DAO object.
    HibernateToDoListDAO htdl = HibernateToDoListDAO.getInstance();
    static User globalUser;

    /**
     * Servlet init() method implementation
     * @see HttpServlet#init()
     */
    @Override
    public void init() throws ServletException
    {
        super.init();
    }

    /**
     * return the user that is signed in to get its items
     * @return globalUser
     */
    public static User getCurrentUser()
    {
        if (globalUser!=null)
           return globalUser;
        else return null;
    }

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Router() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        RequestDispatcher dispatcher = null;

        try{
            String actionToDo = request.getParameter("page");

            if (actionToDo == null || actionToDo == "" || actionToDo.equals("")){
                actionToDo = "task";
            }

            switch (actionToDo)
            {
                case "signUp":
                    signUp(request, response);
                    break;
                case "task":
                    task(request, response);
                    break;
                case "main":
                    main(request, response);
                    break;
                case "signIn":
                    signIn(request, response);
                    break;
                case "addTask":
                    addTask(request, response);
                    break;
                case "logout":
                    logout(request, response);
                    break;
                case "deleteTask":
                    deleteTask(request, response);
                    break;
                case "updateTask":
                    updateTask(request, response);
                    break;
                case "error":
                    dispatcher = request.getRequestDispatcher("error.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
            if (linkTo!=null) {
                dispatcher = request.getRequestDispatcher(linkTo + ".jsp");
                dispatcher.forward(request, response);
            }

        } catch (SecurityException | IllegalArgumentException e) {
            //e.printStackTrace();
            request.setAttribute("error", e.getMessage().toString());
            dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * if you are in task page goto deleteTask and delete the task you want by its name and description
     * if you are in deleteTask page return to task page
     * @param request
     * @param response
     * @throws ToDoListException
     */
    public void deleteTask(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try {
            String taskId = request.getParameter("delete");
            String isDelete = request.getParameter("isDelete");

            // the app in task page getting the clicked item
            if (taskId != null && !taskId.equals("")) {
                Integer id = Integer.parseInt(taskId);
                Items deleteItem = htdl.getItem(id);
                request.setAttribute("taskName", deleteItem.getItemName());
                request.setAttribute("description", deleteItem.getDescription());
                request.setAttribute("taskId", ((Integer) deleteItem.getId()).toString());
                linkTo = "deleteTask";
            }

            // the app in delete page and deleting the item in the DB
            if (isDelete != null && isDelete.equals("true")) {
                if (request.getParameter("flag").equals("canceled")) { // if cancel button clicked return to task page without deleting the item
                    linkTo = "task";
                } else { // update and return to task page
                    Integer deleteId = Integer.parseInt(request.getParameter("deleteId"));
                    if (deleteId != null) {
                        htdl.deleteItem(deleteId);
                        isSuccess = true;
                        linkTo = "task";
                    }
                }
            }
        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }

    }

    /**
     * if you are in task page goto updateTask and update the task you want by its name (enter new description)
     * if you are in updateTask page go back to task page
     * @param request
     * @param response
     * @throws ToDoListException
     */
    public void updateTask(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try {
            String taskId = request.getParameter("update");
            String isUpdate = request.getParameter("isUpdate");

            // the app in task page getting the clicked item
            if (taskId != null && !taskId.equals("")) {
                Integer id = Integer.parseInt(taskId);
                Items editItem = htdl.getItem(id);
                request.setAttribute("name", editItem.getItemName());
                request.setAttribute("desc", editItem.getDescription());
                request.setAttribute("taskId", ((Integer) editItem.getId()).toString());
                linkTo = "updateTask";
            }

            // the app in update page and updates the selected item in the DB
            if (isUpdate != null && isUpdate.equals("task")) {
                String itemName = request.getParameter("itemName");
                String newDescription = request.getParameter("newDescription");

                if (request.getParameter("flag").equals("canceled")) { // if cancel button clicked return to task page without updating the item
                    linkTo = "task";
                } else if (itemName.equals("") || newDescription.equals("")) { // if the name or description is empty
                    Integer updateId = Integer.parseInt(request.getParameter("taskId"));
                    Items editItem = htdl.getItem(updateId);
                    request.setAttribute("name", editItem.getItemName());
                    request.setAttribute("desc", editItem.getDescription());
                    request.setAttribute("taskId", ((Integer) editItem.getId()).toString());
                    linkTo = "updateTask";
                } else { // delete and return to task page
                    Integer updateId = Integer.parseInt(request.getParameter("taskId"));
                    if (itemName != null && newDescription != null && updateId != null) {
                        if (!itemName.equals("") && !newDescription.equals("") && !itemName.isEmpty()) {
                            Items item = new Items(itemName, newDescription, globalUser.getUserId());
                            htdl.updateItem(item, updateId);
                            isSuccess = true;
                            linkTo = "task";
                        }
                    }
                }
            }
        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }
    }

    /**
     * nullify user when pressing the logout button
     * @param request
     * @param response
     * @throws ToDoListException
     */
    public void logout(HttpServletRequest request, HttpServletResponse response){
        globalUser=null;
        linkTo="signIn";
    }

    /**
     * if you are in task page goto addTask and add task
     * if you are in addTask page goto task page
     * @param request the item name
     * @param response the description of the item
     */
    public void addTask(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try {
            String itemName = request.getParameter("itemName");
            String description = request.getParameter("description");

            if (itemName != null && description != null) {
                if (!itemName.equals("") && !description.equals("")) {
                    if (request.getParameter("flag").equals("canceled")) { // return to task page without adding new item
                        linkTo = "task";
                    } else { // add new item in DB and return to task page
                        Items item = new Items(itemName, description, globalUser.getUserId());
                        htdl.addItem(item);
                        isSuccess = true;
                        linkTo = "task";
                    }
                }
            } else { // the app is in task page and the user want to add new item
                linkTo = "addTask";
            }
        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }
    }

    /**
     * method that adds the new user email and password from the app signUp button to the database
     * @param request HttpServletRequest to get the parameters of the user
     * @param response
     * @throws ToDoListException
     */
    public void signUp(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try {
            boolean isSignUp = false;
            String firstName = request.getParameter("txt-first-name");
            String lastName = request.getParameter("txt-last-name");
            String email = request.getParameter("txt-email");
            String password = request.getParameter("txt-password");
            String passwordConfirm = (String) request.getParameter("txt-password-confirm");
            String isregister=(String)request.getParameter("registerSuccess");
            if (isregister!=null && isregister.equals("success"))
            {
                isSuccess = true;
                linkTo = "main";
            }
            else {
                if (passwordConfirm.equals(password) && !password.equals("") && !passwordConfirm.equals("")
                        && !firstName.equals("") && !lastName.equals("") && !email.equals("")) {
                    User registerUser = new User(firstName, lastName, password, email);
                    htdl.addUser(registerUser);
                    isSuccess = true;
                    // linkTo = "main";
                    request.setAttribute("isRegister", true);
                } else {

                    if (firstName.equals("") && lastName.equals("")) {
                        request.setAttribute("signUpResult", true);
                        request.setAttribute("title", "Empty fields");
                        request.setAttribute("message", "one or more of inputs are empty");
                    } else if (!passwordConfirm.equals(password) || passwordConfirm.equals(password) || password.equals("")) {
                        request.setAttribute("signUpResult", true);
                        request.setAttribute("title", "Unmatched passwords!");
                        request.setAttribute("message", "password confirmed not match!");
                    }
                    linkTo = "signUp";
                }
            }
        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }
    }


    /**
     * task page contains all the items of the logged in user
     * has 3 buttons (options): add, update and delete item
     * @param request
     * @param response
     * @throws ToDoListException
     */
    public void task(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try{
            String actionTask = request.getParameter("page");
            if (actionTask ==null || actionTask.equals("")){
                linkTo="task";
            }if((!request.isRequestedSessionIdFromURL() && actionTask==null) ||actionTask.equals(""))
            {
                actionTask="signIn";
            }
            switch (actionTask){
                case "addTask":
                    linkTo = "addTask";
                    break;
                case "deleteTask":
                    linkTo = "deleteTask";
                    break;
                case "updateTask":
                    linkTo = "updateTask";
                    break;
                case "signIn":
                    linkTo = "signIn";
                    break;
            }
        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }
    }

    /**
     * signIn page by email and password
     * @param request
     * @param response
     * @throws ToDoListException
     */
    public void signIn(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try{
            String email = request.getParameter("txt-email");
            String password = request.getParameter("txt-password");
            boolean emailFromDataBase = htdl.getUserByEmail(email, password);

            if (emailFromDataBase) { // the user found in DB, then go to task page
                isSuccess = true;
                linkTo = "task";
                globalUser = htdl.getUser(email);

            }else{
                request.setAttribute("loginResult", true);
            }
        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }
    }

    /**
     * main page contains signIn or signUp options
     * @param request
     * @param response
     * @throws ToDoListException
     */
    public void main(HttpServletRequest request, HttpServletResponse response) throws ToDoListException {
        try {
            String goTo = request.getParameter("main");

            if (goTo != null) {
                linkTo = goTo;
            } else {
                linkTo = "main";
            }

        } catch (ToDoListException todo) {
            request.setAttribute("error", todo.getMessage().toString());
            linkTo = "error";
        }
    }
}
