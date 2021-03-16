<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolStatusFab.aspx.cs" Inherits="SpoolControl_SpoolStatusFab" Title="Spool Status" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:DetailsView ID="SpoolDetailsView" runat="server" AutoGenerateRows="False" SkinID="DetailsViewSkin"
                DataKeyNames="SPL_ID" DataSourceID="spoolFabDataSource" Width="650px"
                OnModeChanging="SpoolDetailsView_ModeChanging" OnItemUpdating="SpoolDetailsView_ItemUpdating">
                <EmptyDataTemplate>
                    No Data to display!
                </EmptyDataTemplate>
                <Fields>
                    <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                        ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                    <asp:BoundField DataField="SPL_TITLE" HeaderText="Spool Title" ReadOnly="True" SortExpression="SPL_TITLE" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="HOLD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Hold Date" HtmlEncode="False" SortExpression="HOLD_DATE" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="REL_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Release Date" HtmlEncode="False" SortExpression="REL_DATE" />
                    <asp:BoundField DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Weld Date" HtmlEncode="False" SortExpression="WELD_DATE" ReadOnly="true" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="DIM_CHECK" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Dimension Check" HtmlEncode="False" SortExpression="DIM_CHECK" />

                    <asp:BoundField ApplyFormatInEditMode="True" DataField="HYDRO_REP_NO" HeaderText="HydroTest Report No" HtmlEncode="False" SortExpression="HYDRO_REP_NO" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="HYDRO_REP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="HydroTest Report Date" HtmlEncode="False" SortExpression="HYDRO_REP_DATE" />

                    <asp:BoundField ApplyFormatInEditMode="True" DataField="INT_BLST_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Int Blasting Date" HtmlEncode="False" SortExpression="INT_BLST_DATE" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="PAINT_CLR" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Paint Clear Date" HtmlEncode="False" SortExpression="PAINT_CLR" />
                    <asp:BoundField DataField="PAINT_REP" HeaderText="Paint Report No" SortExpression="PAINT_REP" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="INTER_PAINT_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Intermediate Date" HtmlEncode="False" SortExpression="INTER_PAINT_DATE" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="FINAL_PAINT_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Second Coating Date" HtmlEncode="False" SortExpression="FINAL_PAINT_DATE" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="PACKING_REL" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Packing Release" HtmlEncode="False" SortExpression="PACKING_REL" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="CLEAR_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="QC Clear Date" HtmlEncode="False" SortExpression="CLEAR_DATE" />
                    <asp:BoundField DataField="PKL_PSV_NO" HeaderText="Pickling/ Pass No" SortExpression="PKL_PSV_NO" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="SITE_WELDING" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Site Welding" HtmlEncode="False" SortExpression="SITE_WELDING" />
                    <asp:BoundField ApplyFormatInEditMode="True" DataField="SITE_EREC" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Site Erection" HtmlEncode="False" SortExpression="SITE_EREC" />
                    <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Fields>
            </asp:DetailsView>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="spoolFabDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE, WELD_DATE, HOLD_DATE, REL_DATE, INT_BLST_DATE, DIM_CHECK, PAINT_CLR, PAINT_REP, PACKING_REL, CREATE_DATE, PKL_PSV_NO, SITE_WELDING, SITE_EREC, INTER_PAINT_DATE, FINAL_PAINT_DATE, CLEAR_DATE, REMARKS,HYDRO_REP_NO,HYDRO_REP_DATE FROM VIEW_ADAPTER_SPOOL WHERE (SPL_ID = :SPL_ID)"
        UpdateCommand="UPDATE PIP_SPOOL SET HOLD_DATE = :HOLD_DATE, REL_DATE = :REL_DATE, INT_BLST_DATE = :INT_BLST_DATE, DIM_CHECK = :DIM_CHECK, PAINT_CLR = :PAINT_CLR, PAINT_REP = :PAINT_REP, PACKING_REL = :PACKING_REL, PKL_PSV_NO = :PKL_PSV_NO, SITE_WELDING = :SITE_WELDING, SITE_EREC = :SITE_EREC, CLEAR_DATE = :CLEAR_DATE, INTER_PAINT_DATE = :INTER_PAINT_DATE, FINAL_PAINT_DATE = :FINAL_PAINT_DATE, REMARKS = :REMARKS WHERE (SPL_ID = :SPL_ID)">
        <SelectParameters>            
            <asp:QueryStringParameter DefaultValue="-1" Name="SPL_ID" QueryStringField="SPL_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="HOLD_DATE" />
            <asp:Parameter Name="REL_DATE" />
            <asp:Parameter Name="INT_BLST_DATE" />
            <asp:Parameter Name="DIM_CHECK" />
            <asp:Parameter Name="PAINT_CLR" />
            <asp:Parameter Name="PAINT_REP" />
            <asp:Parameter Name="PACKING_REL" />
            <asp:Parameter Name="PKL_PSV_NO" />
            <asp:Parameter Name="SITE_WELDING" />
            <asp:Parameter Name="SITE_EREC" />
            <asp:Parameter Name="CLEAR_DATE" />
            <asp:Parameter Name="INTER_PAINT_DATE" />
            <asp:Parameter Name="FINAL_PAINT_DATE" />
            <asp:Parameter Name="REMARKS" />
            <asp:Parameter Name="SPL_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>