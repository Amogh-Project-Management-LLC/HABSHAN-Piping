<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SplProgressSelection.aspx.cs" Inherits="SpoolProgressSelection_1"
    Title="Daily Progrss" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
              <tr>
                <td style="width: 125px; background-color: Gainsboro; vertical-align: top">category
                </td>
                <td>
                    <telerik:RadComboBox ID="RadComboBox1" runat="server" AppendDataBoundItems="true" Filter="Contains" EmptyMessage="Select Shop/Field"
                        Width="250px" 
                        AutoPostBack="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="SHOP" Value="1" />
                            <telerik:RadComboBoxItem Text="FIELD"  Value="2" />
                        </Items>                      
                    </telerik:RadComboBox>
                     <asp:RequiredFieldValidator ID="Categoty" runat="server" ControlToValidate="RadComboBox1" ErrorMessage="*">  
                                 </asp:RequiredFieldValidator> 
                </td>
            </tr>
             <tr>
                <td style="width: 125px; background-color: Gainsboro; vertical-align: top"> Report category
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlModule" runat="server" AppendDataBoundItems="true" Filter="Contains" EmptyMessage="Select Report"
                        Width="250px" 
                        AutoPostBack="true">
                        <Items>
                            <telerik:RadComboBoxItem Text="Welding" Value="1" />
                            <telerik:RadComboBoxItem Text="NDE"  Value="2" />
                            <telerik:RadComboBoxItem Text="Painting" Value="3" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            
            <tr>
                <td style="width: 125px; background-color: Gainsboro; vertical-align: top">Subcon
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlSubcon" runat="server" DataSourceID="SubConDataSource" DataTextField="SUB_CON_NAME" AllowCustomText="true" Filter="Contains"
                        DataValueField="SUB_CON_NAME" Width="250px" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" EmptyMessage="Select Subcon"
                        AutoPostBack="true">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 125px; background-color: Gainsboro; vertical-align: top">Area
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlArea" runat="server" DataSourceID="AreaDataSource" DataTextField="AREA_GROUP" AllowCustomText="true" Filter="Contains"
                        DataValueField="AREA_GROUP" Width="250px" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" EmptyMessage="Select Area Group"
                         AutoPostBack="true">
                    </telerik:RadComboBox>
                </td>
            </tr>

        </table>
    </div>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>
  
    <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"      
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" select DISTINCT AREA_GROUP FROM IPMS_AREA "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SubConDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT SUB_CON_NAME FROM SUB_CONTRACTOR"></asp:SqlDataSource>
    
</asp:Content>
