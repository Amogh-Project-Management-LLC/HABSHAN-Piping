<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JC_MIV_Rev.aspx.cs" 
  MasterPageFile="~/MasterPage.master"  Inherits="SpoolFabJobCard_JC_MIV_Rev_Register" Title="JC MIV Revisions" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                     <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                   <telerik:RadButton ID="btnRev" runat="server" Text="New Revision" Width="120" OnClick="btnRev_Click"></telerik:RadButton>
                </td>
                 <td>
                   <telerik:RadButton ID="btnItems" runat="server" Text="Items" Width="80" OnClick="btnItems_Click"></telerik:RadButton>
                </td>
                 <td>
                            <telerik:RadDropDownList ID="ddlReportType" runat="server" Width="150" AutoPostBack="true" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged" >
                                <Items>
                                    <telerik:DropDownListItem Value="-1" Text="Select Report" />
                                    <telerik:DropDownListItem Value="3" Text="Summary" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
            </tr>
        </table>
    </div>


    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="MIVRevGrid" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                    DataSourceID="mivRevDataSource" PageSize="18" Width="100%" DataKeyNames="ISSUE_REV_ID">
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <MasterTableView DataSourceID="mivRevDataSource" DataKeyNames="ISSUE_REV_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="10px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this MIV Rev Transmittal?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                            </telerik:GridButtonColumn>


                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="Issue Number" SortExpression="ISSUE_NO" ItemStyle-Width="120px" ReadOnly="true" />                      
                            <telerik:GridBoundColumn DataField="REV_NO" HeaderText="Rev No" SortExpression="REV_NO" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="MIVR_NO" HeaderText="MIVR No" SortExpression="MIVR_NO" ReadOnly="true"  />
                            <telerik:GridBoundColumn DataField="REV_CREATED_AT" HeaderText="Rev Created" SortExpression="REV_CREATED_AT" ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}" />
                            <telerik:GridBoundColumn DataField="REV_ISSUE_BY" HeaderText="Rev Created By" SortExpression="REV_ISSUE_BY" />
                            <telerik:GridBoundColumn DataField="PDF_FLG" HeaderText="PDF FLG" SortExpression="PDF_FLG" ReadOnly="true"/>
                             
                            <telerik:GridBoundColumn DataField="REV_REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="mivRevDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsFabricationJCTableAdapters.PIP_MAT_ISSUE_WO_REVTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_ISSUE_REV_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
           <asp:Parameter Name="MIVR_NO" Type="String" />
            <asp:Parameter Name="REV_REMARKS" Type="String" />
            <asp:Parameter Name="Original_ISSUE_REV_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
</asp:Content>
