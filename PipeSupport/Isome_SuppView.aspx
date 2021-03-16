<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Isome_SuppView.aspx.cs" Inherits="PipeSupport_Isome_SuppView"
    Title="Details" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
    </div>
    <div>
        <asp:DetailsView ID="supportJcDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="DetailsView_SqlDataSource"
            SkinID="DetailsViewSkin" Width="600px">
            <FieldHeaderStyle Width="180px" />
            <Fields>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="isometric No" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Support Tag No" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="MAT_DESCR" HeaderText="Support Description" SortExpression="MAT_DESCR" />

                <asp:BoundField DataField="SUPP_JC_NO" HeaderText="Support Fab JC No" SortExpression="SUPP_JC_NO" />
                <asp:BoundField DataField="SUPP_JC_DATE" HeaderText="Support Fab JC Date" SortExpression="SUPP_JC_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SUPP_FAB_SHOP_NO" HeaderText="Fab Shop" SortExpression="SUPP_FAB_SHOP_NO" />
                <asp:BoundField DataField="PIPING_JC_NO" HeaderText="Piping Jobcard No" SortExpression="PIPING_JC_NO" />
                <asp:BoundField DataField="PIPING_JC_DATE" HeaderText="Piping Jobcard Date" SortExpression="PIPING_JC_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />

                <asp:BoundField DataField="FIELD_SC_NAME" HeaderText="Field Subcon" SortExpression="FIELD_SC_NAME" />
                <asp:BoundField DataField="ISO_ON_HOLD" HeaderText="Iso On Hold" SortExpression="ISO_ON_HOLD" />
                <asp:BoundField DataField="BOM_HOLD_DATE" HeaderText="BOM Hold Date" SortExpression="BOM_HOLD_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="BOM_REL_DATE" HeaderText="BOM Release Date" SortExpression="BOM_REL_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SPL_MAT_TYPE" HeaderText="Spool Mat Type" SortExpression="SPL_MAT_TYPE" />
                <asp:BoundField DataField="SUPP_MAT_TYPE" HeaderText="Support Mat Type" SortExpression="SUPP_MAT_TYPE" />
                <asp:BoundField DataField="MAT_CLASS" HeaderText="Material Class" SortExpression="MAT_CLASS" />
                <asp:BoundField DataField="SPL_WELD_DATE" HeaderText="Spool Weld Date" SortExpression="SPL_WELD_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SPL_RECVD_SITE" HeaderText="Spool Received Site" SortExpression="SPL_RECVD_SITE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SPL_PAINT_CODE" HeaderText="Spool Paint Code" SortExpression="SPL_PAINT_CODE" />
                <asp:BoundField DataField="SF_FLG" HeaderText="SF" SortExpression="SF_FLG" />
                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                <asp:BoundField DataField="NET_QTY" HeaderText="Qty" SortExpression="NET_QTY" />
                <asp:BoundField DataField="FAB_DATE" HeaderText="Fabrication Date" SortExpression="FAB_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="ACTUAL_WT" HeaderText="Actual Weight" SortExpression="ACTUAL_WT" />
                <asp:BoundField DataField="PACKING_NO" HeaderText="Packing No" SortExpression="PACKING_NO" />
                <asp:BoundField DataField="SUPP_PACKING_DATE" HeaderText="Packing Date" SortExpression="SUPP_PACKING_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SUPP_SHIP_DEPARTURE_DATE" HeaderText="Ship Departure Date" SortExpression="SUPP_SHIP_DEPARTURE_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="RECV_DATE" HeaderText="Receive Date" SortExpression="RECV_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SUPP_BOX_NO" HeaderText="Box No" SortExpression="SUPP_BOX_NO" />
                <asp:BoundField DataField="EREC_DATE" HeaderText="Erection Date" SortExpression="EREC_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="SWN_NO" HeaderText="SWN No" SortExpression="SWN_NO" />
                <asp:BoundField DataField="SWN_DATE" HeaderText="SWN Date" SortExpression="SWN_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="REL_NO" HeaderText="Release No" SortExpression="REL_NO" />
                <asp:BoundField DataField="REL_DATE" HeaderText="Release Date" SortExpression="REL_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
            </Fields>
        </asp:DetailsView>
    </div>

    <asp:SqlDataSource ID="DetailsView_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PIPING_JC_NO, PIPING_JC_DATE, ISO_TITLE1,
FIELD_SC_NAME, ISO_ON_HOLD, BOM_HOLD_DATE, BOM_REL_DATE, SHEET, SPOOL,
SPL_MAT_TYPE, SUPP_MAT_TYPE, MAT_CLASS, SPL_WELD_DATE, SPL_RECVD_SITE, SPL_PAINT_CODE,
PT_NO, ITEM_NAM, MAT_CODE1, MAT_DESCR, SF_FLG, UOM, NET_QTY, SUPP_JC_NO, SUPP_JC_DATE,
SUPP_FAB_SHOP_NO, FAB_DATE, ACTUAL_WT, PACKING_NO, SUPP_PACKING_DATE, SUPP_SHIP_DEPARTURE_DATE,
RECV_DATE, SUPP_BOX_NO, EREC_DATE, CRD_DATE, SWN_NO, SWN_DATE, REL_NO, REL_DATE
FROM VIEW_TOTAL_SUPP
WHERE (BOM_ID = :BOM_ID)">
        <SelectParameters>            
            <asp:QueryStringParameter DefaultValue="-1" Name="BOM_ID" QueryStringField="BOM_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>