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
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                btnLogout.Style.Add("display", "block");    // Shows the "Logout" button/link
            }
            else                                            // If not authenticated
            { 
                btnLogout.Style.Add("display", "none");     // Hides the "Logout" button/link
                                                            // And not in the default page
                if (System.IO.Path.GetFileName(Request.Url.ToString()).ToLower().Substring(0, 3) != "def")
                    Response.Redirect("~/Default.aspx");
            }
        }

        // Logs out the current user
        public void BtnLogout_Click(object sender, EventArgs e)
        {
            // If the User is authenticated, then it proceeds to logout
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                authenticationManager.SignOut();
            }

            Session["userName"] = "";           // Empties the user name in the Session

            Response.Redirect("~/Default.aspx");

        }
    }
}