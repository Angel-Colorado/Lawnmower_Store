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
using System.Globalization;
using LibraryFinal;

namespace WebFinal
{
    public partial class Orders : System.Web.UI.Page
    {
        // A text to help the user understand how the Application works
        private const string helpText = "<p>" +
            "<strong class='text-primary'>» Search:</strong> You can perform a Search by entering one of the available parameters.<br>" +
            "<strong>» Add Order:</strong> You can Add an Order by clicking the correspondent button (green).<br>" +
            "<strong>» Edit | Delete Order:</strong> You can Edit or Delete an Order once you click on their " +
                "'Details' button (light blue outlined).<br>" +
            "<strong class='text-primary'>» OrderLines:</strong> You might see the OrderLines on the bottom " +
                "table if the Order has any attached to it.<br>" +
            "<strong class='text-primary'>» Add OrderLine:</strong> You can Add an OrderLine by clicking the " +
                "correspondent button (green). You cannot Add an OrderLine to a different Order than the " +
                "currently selected one, however you might change any OrderLine from one order to another by Editing it.<br>" +
            "<strong class='text-primary'>» Edit | Delete OrderLine:</strong> You can Edit or Delete an OrderLine " +
                "once you click on their 'Details' button (light blue outlined)." +
            "</p>";

        public double sumTotals;    // This variable will hold the totals for the product table
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatus.Text = helpText;  // Loads the 'Help Text' only the 1st. time

                // Finds the Button in the Header Row and disables it
                Button theButton = (Button)gvProducts.HeaderRow.FindControl("btnAddLine");
                theButton.Attributes.Add("disabled", "disabled");
            }
        }

        protected void BtnSearchClr_Click(object sender, EventArgs e)
        {
            ordRecSearch.Text = "";
        }

        // Triggers the "Insert record" on the FormView (Orders)
        protected void BtnAddOrder_Click(object sender, EventArgs e)
        {
            fvOrderReceipt.ChangeMode(FormViewMode.Insert);
        }

        // Triggers the "Insert record" on the FormView (Lines)
        protected void BtnAddLine_Click(object sender, EventArgs e)
        {
            fvOrderLine.ChangeMode(FormViewMode.Insert);
        }

        // Prints the Number of Rows retrieved through the Object Data Source
        protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (IsPostBack)
                lblStatus.Text = $" Order Search Results: {(e.ReturnValue as DataTable).Rows.Count.ToString()}";
        }

        // gvProducts
        protected void ObjectDataSource6_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            sumTotals = 0;

            // Gets the results from the ObjectDataSource and loops through all the
            //  rows adding the partial totals to an accumulator
            foreach (DataRow row in (e.ReturnValue as DataTable).Rows)  // Sums up all of the 'lineTotals'
                sumTotals += double.Parse(row.ItemArray[3].ToString(), NumberStyles.AllowThousands | NumberStyles.AllowDecimalPoint | NumberStyles.AllowCurrencySymbol);
        }

        // When an Order is selected, enables the 'Add Line' button
        protected void GvOrderReceipts_SelectedIndexChanged(object sender, EventArgs e)
        {   
            // Finds the Button in the Header Row
            Button theButton = (Button)gvProducts.HeaderRow.FindControl("btnAddLine");
            theButton.Attributes.Remove("disabled");
        }


        protected void FvOrderReceipt_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            // Deals with an Update Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Update record, try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvOrderReceipts.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Updated";
            }
        }

        protected void FvOrderReceipt_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            // Deals with a Delete Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"You cannot Delete an Order that have OrderLines, " +
                    $"try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvOrderReceipts.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Deleted";
            }
        }

        protected void FvOrderReceipt_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            // Deals with an Insert Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Insert record / {e.Exception.Message}";
            }
            else
            {
                gvOrderReceipts.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Created";
            }
        }


        protected void FvOrderLine_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            // Deals with an Update Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Update record, try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvOrderReceipts.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Updated";
            }
        }

        protected void FvOrderLine_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            // Deals with a Delete Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Delete record, try again or select another record / {e.Exception.Message}";
            }
            else
            {
                gvOrderReceipts.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Deleted";
            }
        }

        protected void FvOrderLine_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            // Deals with an Insert Exception
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblStatus.Text = $"Unable to Insert record / {e.Exception.Message}";
            }
            else
            {
                gvOrderReceipts.DataBind();     // Refresh the GridView without PostBack, to preserve the Message
                lblStatus.Text = $"Record successfully Created";
            }
        }
    }
}