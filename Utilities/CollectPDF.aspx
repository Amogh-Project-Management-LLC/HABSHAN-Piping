<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="CollectPDF.aspx.cs" Inherits="Utilities_CollectPDF" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Isometric / Spool PDF Collection">
        <table>
            <tr>
                <td>ISO Spoolgen PDFs:
                </td>
                <td>
                    <telerik:RadButton ID="btnSpoolgenPDF" runat="server" Text="Collect" Width="110" OnClick="btnSpoolgenPDF_Click"></telerik:RadButton>
                </td>

                <td>ISO Hardcopy PDFs:
                </td>
                <td>
                    <telerik:RadButton ID="btnHardcopy" runat="server" Text="Collect" Width="110" OnClick="btnHardcopy_Click"></telerik:RadButton>
                </td>
                <td>ISO As-built PDFs:
                </td>
                <td>
                    <telerik:RadButton ID="btnAsbuilt" runat="server" Width="110" Text="Collect"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>Spool PDFs</td>
                <td>
                    <telerik:RadButton ID="btnSplPDF" runat="server" Width="110" Text="Collect" OnClick="btnSplPDF_Click"></telerik:RadButton>
                </td>
                <td>Isometric Marking PDF:</td>
                <td>
                    <telerik:RadButton ID="RadButton1" runat="server" Width="110" Text="Collect" OnClick="RadButton1_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" GroupingText="Collect MTCs/MRIR">
        <table>
            <tr>
                <td>MTCs:
                </td>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Width="110" Text="Collect" OnClick="btnMTC_Click"></telerik:RadButton>
                </td>
                <td>MRIR PDFs:
                </td>
                <td>
                    <telerik:RadButton ID="btnMRIR" runat="server" Text="Collect" Width="110"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="PanelCollect" runat="server" GroupingText="Update PDF Flag">
        <table style="width:100%">
            <tr>
                <td>Isometric SG Flag:
                </td>
                <td>
                    <telerik:RadButton ID="RadButton2" runat="server" Width="90" Text="Update" OnClick="RadButton2_Click"></telerik:RadButton>
                </td>
                <td>Spool Flag:
                </td>
                <td>
                    <telerik:RadButton ID="RadButton3" runat="server" Text="Update" Width="90" OnClick="RadButton3_Click"></telerik:RadButton>
                </td>           
                <td>Isometric HC Flag:
                </td>
                <td>
                    <telerik:RadButton ID="btnHCFlag" runat="server" Width="90" Text="Update" OnClick="btnHCFlag_Click"></telerik:RadButton>
                </td>                
            </tr>
        </table>
    </asp:Panel>

    <div class="demo-container size-narrow">

        <telerik:RadProgressManager ID="RadProgressManager1" runat="server" />
        <telerik:RadProgressArea RenderMode="Lightweight" ID="RadProgressArea1" runat="server" Width="500px" />
    </div>
</asp:Content>

