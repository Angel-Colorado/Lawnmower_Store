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
    public partial class Inventory : System.Web.UI.Page
    {
        // A text to help the user understand how the Application works
        private const string helpText = "<p>" +
            "<strong class='text-primary'>» Search:</strong> You can perform a Search by entering one of the available parameters.<br>" +
            "<strong>» Add Inventory:</strong> You can Add an InventoryProduct by clicking the correspondent button (green).<br>" +
            "<strong>» Edit | Delete Inventory:</strong> You can Edit or Delete an InventoryProduct once you click on their 'Details' button (light blue outlined).<br>" +
            "</p>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                lblStatus.Text = helpText;  // Loads the 'Help Text' only the 1st. time
        }

        protected void BtnSearchClr_Click(object sender, EventArgs e)
        {
            invSearch.Text = "";
        }

        // Triggers the "Insert record" on the FormView
        protected void BtnAddInventory_Click(object sender, EventArgs e)
        {
            fvInventory.ChangeMode(FormViewMode.Insert);
        }

        // Prints the Number of Rows retrieved through the Object Data Source
        protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (IsPostBack)
                lblStatus.Text = $"Inventory Search Results: {(e.ReturnValue as DataTable).Rows.Count.ToString()}";
        }

        protected void FvInventory_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            // Deals with an Update Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Update record, try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvInventory.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Updated";
            }
        }

        protected void FvInventory_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            // Deals with a Delete Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"You cannot Delete an InventoryProduct that is already in an OrderLine, " +
                    $"try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvInventory.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Deleted";
            }
        }

        protected void FvInventory_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            // Deals with an Insert Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Insert record / {e.Exception.Message}";
            }
            else
            {
                gvInventory.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Created";
            }
        }
    }
}