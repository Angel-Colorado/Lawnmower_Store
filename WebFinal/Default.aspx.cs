// Name:            Angel Mario Colorado Chairez
// Done for:        PROG1210 / Final Exam Hands-on Project
// Last Modified:   December 16, 2022
// Description:     » Develop a programming solution for the Emma’s Small Engine business case from PROG1180
//                  » Use ADO, Datasets, and programming techniques from PROG1210 to implement the database
//                     functionality of the new Emma’s Small Engine system


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;


namespace WebFinal
{
    public partial class _Default : Page
    {
        static _Default()
        {
            // Creates the following profile:
            //      user: staff
            //      pass: password
            UserStore<IdentityUser> userStore = new UserStore<IdentityUser>();
            UserManager<IdentityUser> manager = new UserManager<IdentityUser>(userStore);

            // If the "staff" user doesn't exist, then creates it
            if (manager.FindByName("staff") == null)
            {
                IdentityUser user = new IdentityUser("staff");
                IdentityResult idResult = manager.Create(user, "password");
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            UserStore<IdentityUser> userStore = new UserStore<IdentityUser>();
            UserManager<IdentityUser> manager = new UserManager<IdentityUser>(userStore);
            IdentityUser user = manager.Find(txtUser.Text, txtPass.Text);

            if (user == null)
            {
                lblStatus.Text = "Username or Password is incorrect";
            }
            else    // Authentication
            {
                var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = manager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
                authenticationManager.SignIn(userIdentity);

                Session["userName"] = txtUser.Text;     // Stores the user name in the Session
                Session["displayLogout"] = "block";     // It'll show the "Logout" button/link
                Response.Redirect("~/Customers.aspx");
            }
        }
    }
}