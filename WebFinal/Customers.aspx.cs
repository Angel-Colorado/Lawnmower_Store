// Name:            Angel Mario Colorado Chairez
// Done for:        PROG1210 / Final Exam Hands-on Project
// Last Modified:   December 16, 2022
// Description:     » Develop a programming solution for the Emma’s Small Engine business case from PROG1180
//                  » Use ADO, Datasets, and programming techniques from PROG1210 to implement the database
//                     functionality of the new Emma’s Small Engine system


using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LibraryFinal;

namespace WebFinal
{
    public partial class Customers : Page
    {
        // A text to help the user understand how the Application works
        private const string helpText = "<p>" +
            "<strong class='text-primary'>» Search:</strong> You can perform a Search by entering one of the available parameters.<br>" +
            "<strong>» Add Customer:</strong> You can Add a Customer by clicking the correspondent button (green).<br>" +
            "<strong>» Edit Customer:</strong> You can Edit a Customer once you click on their 'Details' button (light blue outlined).<br>" +
            "<strong>» Orders:</strong> You might see the Customer's Orders on the bottom table if they have any attached to their profile." +
            "</p>";

        // The validation of the User Authentication is handled in the file Site.Master.cs
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                lblStatus.Text = helpText;  // Loads the 'Help Text' only the 1st. time
        }

        protected void BtnSearchClr_Click(object sender, EventArgs e)
        {
            custSearch.Text = "";
        }

        // Triggers the "Insert record" on the FormView
        protected void BtnAddCustomer_Click(object sender, EventArgs e)
        {
            fvCustomer.ChangeMode(FormViewMode.Insert);
        }

        // Prints the Number of Rows retrieved through the Object Data Source
        protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (IsPostBack)
                lblStatus.Text = $"Customer Search Results: {(e.ReturnValue as DataTable).Rows.Count.ToString()}";
        }

        protected void FvCustomer_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            // Deals with an Update Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Update record, try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvCustomers.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Updated";
            }
        }

        protected void FvCustomer_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            // Deals with an Insert Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Insert record / {e.Exception.Message}";
            }
            else
            {
                gvCustomers.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Created";
            }
        }
    }
}