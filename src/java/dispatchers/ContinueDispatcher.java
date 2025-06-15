/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dispatchers;

import javax.servlet.http.*;

/**
 *
 * @author denan
 */
public class ContinueDispatcher implements Dispatcher{
     @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        return "/jsp/title.jsp";
    }
}
   
