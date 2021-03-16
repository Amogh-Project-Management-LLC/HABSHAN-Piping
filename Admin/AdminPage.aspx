<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AdminPage.aspx.cs" Inherits="Admin_Page" Title="Admin" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:UpdatePanel ID="buttonsUpdatePanel" runat="server">
            <ContentTemplate>
                <table>
                  

                    <tr>
                        <td>
                            <telerik:RadButton ID="btnImportJC" runat="server" Text="Job Card Details" Width="200px"
                                OnClick="btnImportJC_Click">
                            </telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnImportWeld" runat="server" Text="Fitup & Weld Details" Width="200px" OnClick="btnImportWeld_Click">
                            </telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnImportNDT" runat="server" Text="NDT Details" Width="200px" OnClick="btnImportNDT_Click"></telerik:RadButton>
                        </td>
                    </tr>
                 


                </table>
             
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
