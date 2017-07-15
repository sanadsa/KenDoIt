package il.ac.hit.mvcdemo.model;

//import il.ac.hit.mvcdemo.model.*;

import org.hibernate.test.cache.Item;

import javax.servlet.RequestDispatcher;
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
    HibernateToDoListDAO htdl = HibernateToDoListDAO.getInstance();
    static User globalUser;

    /**
     * return the user that is signed in
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        RequestDispatcher dispatcher = null;

        try{
            StringBuffer sb = request.getRequestURL();
            StringTokenizer tokenizer = new StringTokenizer(sb.toString(), "/");
            String actionToDo = request.getParameter("page");

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
            }
            if (linkTo!=null) {
                //dispatcher = request.getRequestDispatcher("task.jsp");
                dispatcher = request.getRequestDispatcher(linkTo + ".jsp");
                dispatcher.forward(request, response);
            }

        } catch (SecurityException | IllegalArgumentException e) {
            e.printStackTrace();
        }
    }

    /**
     * if you are in task page goto deleteTask and delete the task you want by its name and description
     * if you are in deleteTask page return to task page
     * @param request
     * @param response
     */
    public void deleteTask(HttpServletRequest request, HttpServletResponse response){
        String taskId = request.getParameter("delete");
        String isDelete = request.getParameter("isDelete");

        if (taskId != null && !taskId.equals("")) {
            Integer id = Integer.parseInt(taskId);
            Items deleteItem = htdl.getItem(id);
            request.setAttribute("taskName", deleteItem.getItemName());
            request.setAttribute("description", deleteItem.getDescription());
            request.setAttribute("taskId", ((Integer)deleteItem.getId()).toString());
            linkTo = "deleteTask";
        }
        if (isDelete != null && isDelete.equals("true")) {
//            String itemName = request.getParameter("itemName");
//            String description = request.getParameter("description");
            Integer deleteId = Integer.parseInt(request.getParameter("deleteId"));
            if (deleteId != null) {
                htdl.deleteItem(deleteId);
                isSuccess = true;
                linkTo = "task";
            }
        }
    }

    /**
     * if you are in task page goto updateTask and update the task you want by its name (enter new description)
     * if you are in updateTask page go back to task page
     * @param request
     * @param response
     */
    public void updateTask(HttpServletRequest request, HttpServletResponse response){
        String taskId = request.getParameter("update");
        String isUpdate = request.getParameter("isUpdate");

        if (taskId != null && !taskId.equals("")) {
            Integer id=Integer.parseInt(taskId);
            Items editItem = htdl.getItem(id);
            request.setAttribute("name", editItem.getItemName());
            request.setAttribute("desc", editItem.getDescription());
            request.setAttribute("taskId", ((Integer)editItem.getId()).toString());
            linkTo = "updateTask";
            }
        if (isUpdate != null && isUpdate.equals("true")) {
            String itemName = request.getParameter("itemName");
            String newDescription = request.getParameter("newDescription");
            Integer updateId = Integer.parseInt(request.getParameter("taskId"));
            if (itemName != null && newDescription != null && updateId != null) {
                if (!itemName.equals("") && !newDescription.equals("")) {
                    Items item = new Items(itemName, newDescription, globalUser.getUserId());
                    htdl.updateItem(item, updateId);
                    isSuccess = true;
                    linkTo = "task";
                }
            }
        }
    }

    /**
     * nullify user when pressing the logout button
     * @param request
     * @param response
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
    public void addTask(HttpServletRequest request, HttpServletResponse response){
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");

        if(itemName!=null && description!=null){
            if(!itemName.equals("") && !description.equals("")) {
                Items item = new Items(itemName, description, globalUser.getUserId());
                htdl.addItem(item);
                isSuccess = true;
                linkTo = "task";
            }
        } else{
            linkTo = "addTask";
        }
    }

    /**
     * method that adds the new user email and password from the app signUp button to the database
     * @param request HttpServletRequest to get the parameters of the user
     * @param response
     */
    public void signUp(HttpServletRequest request, HttpServletResponse response){
        boolean isSignUp = false;
        String firstName = request.getParameter("txt-first-name");
        String lastName = request.getParameter("txt-last-name");
        String email = request.getParameter("txt-email");
        String password = request.getParameter("txt-password");
        String passwordConfirm=(String)request.getParameter("txt-password-confirm");

        //register new user
        if(passwordConfirm.equals(password) && !password.equals("") && !passwordConfirm.equals("")
                && !firstName.equals("") && !lastName.equals("") && !email.equals("")){
            User registerUser = new User(firstName, lastName, password, email);
            htdl.addUser(registerUser);
            isSuccess=true;
            linkTo = "task";
         //  dispatcher = request.getRequestDispatcher("task.jsp");
//            try{
//               dispatcher.forward(request, response);
//
//            } catch (ServletException e){
//                e.printStackTrace();
//            } catch (IOException e){
//                e.printStackTrace();
            }
        //else {
//            request.setAttribute("error", "true");
//        }
    }

    /**
     * task page of the user that logged in
     * @param request
     * @param response
     */
    public void task(HttpServletRequest request, HttpServletResponse response){
        try{
            String actionTask = request.getParameter("page");

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
            }
        }catch (ToDoListException todo){
            todo.printStackTrace();
        }
    }

    /**
     * signIn page by email and password
     * @param request
     * @param response
     */
    public void signIn(HttpServletRequest request, HttpServletResponse response){
        try{
            String email = request.getParameter("txt-email");
            String password = request.getParameter("txt-password");
            boolean emailFromDataBase = htdl.getUserByEmail(email, password);

            if(emailFromDataBase){
                isSuccess = true;
                linkTo = "task";
                globalUser = htdl.getUser(email);
            }
        }catch (ToDoListException se){
            se.printStackTrace();
        }
    }

    /**
     * signIn or signUp page
     * @param request
     * @param response
     */
    public void main(HttpServletRequest request, HttpServletResponse response){
        String goTo = request.getParameter("main");

        if(goTo != null){
            linkTo=goTo;
        }else{
            linkTo="main";
        }
    }
}
