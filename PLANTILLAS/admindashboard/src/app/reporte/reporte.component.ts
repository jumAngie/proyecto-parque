import { Component, OnInit } from '@angular/core';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import { TicketsCliente } from '../Models/TicketsCliente';
import { ViewChild } from '@angular/core';
import { ElementRef } from '@angular/core';
import { ParqServicesService } from '../ParqServices/parq-services.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-reporte',
  templateUrl: './reporte.component.html',
  styleUrls: ['./reporte.component.css']
})
export class ReporteComponent implements OnInit {
  ticketsInforme!: TicketsCliente[];
  @ViewChild('pdfViewer') pdfViewer!: ElementRef;

  constructor(
    private service: ParqServicesService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.getData();
    setTimeout(() => {
      this.generatePDF();
    }, 2000);
  }

  getData() {
    this.service.getReporte(3).subscribe((response: any) => {
      if (response.success) {
        this.ticketsInforme = response.data;
        console.log(this.ticketsInforme);
      }
    });
  }

  generatePDF(): void {
    const doc = new jsPDF();
  
    const header = (doc: any) => {
      doc.setFontSize(18);
      const pageWidth = doc.internal.pageSize.width;
      doc.setTextColor(40);
  
      // Agregar imagen
      const imgData = 'https://i.ibb.co/WHS3vpM/header-image.png';
      doc.addImage(imgData, 'PNG', 10, 10, 50, 20); // Ajusta la posición y las dimensiones de la imagen según sea necesario
  
      // Agregar título
      doc.setFont('Pacifico', 'bold');
      doc.text('Tickets vendidos', 10, 30); // Ajusta la posición del título según sea necesario
  
      // Agregar subtítulo con las fechas de inicio y fin
      doc.setFontSize(16);
      doc.setFont('Arial', 'normal');
      doc.text('Fecha de inicio: 01/06/2023', 10, 50);
      doc.text('Fecha de fin: 30/06/2023', 10, 65);
    };
  
    const footer = (doc: any) => {
      doc.setFontSize(12);
      doc.setFont('Pacifico', 'normal');
      doc.text('¡Gracias por su visita!', 85, doc.internal.pageSize.height - 10, {
        align: 'left'
      });
    };
  
    const mantenimientos: TicketsCliente[] = this.ticketsInforme;
  
    const columns = [
      { header: 'Nombre del cliente', dataKey: 'clie_Nombres' },
      { header: 'Identificación', dataKey: 'clie_DNI' },
      { header: 'Teléfono', dataKey: 'clie_Telefono' },
      { header: 'Ticket', dataKey: 'tckt_Nombre' },
      { header: 'Cantidad', dataKey: 'ticl_Cantidad' },
      { header: 'Forma de pago', dataKey: 'pago_Nombre' }
    ] as { header: string; dataKey: keyof TicketsCliente }[];
  
    // Llamar a la función de encabezado en la primera página
    header(doc);
  
    // Calcular el espacio disponible para el contenido de la tabla en cada página
    const startY = doc.previousAutoTable.finalY || 80; // La posición de inicio de la primera tabla es 80
    const pageHeight = doc.internal.pageSize.height;
    let availableSpace = pageHeight - startY - 20; // 20 es un margen inferior
  
    // Establecer estilos para la tabla
    doc.setFontSize(12);
    doc.setFillColor(245, 245, 245); // Color de fondo para las celdas de encabezado
    doc.setTextColor(0); // Color del texto para las celdas de encabezado
    doc.setFont('Arial', 'bold');
  
    let currentPage = 1;
    let tableDataIndex = 0;
  
    while (tableDataIndex < mantenimientos.length) {
      // Obtener el contenido de la tabla en formato adecuado para la página actual
      const tableData = mantenimientos
        .slice(tableDataIndex)
        .map((mantenimiento) => columns.map((column) => mantenimiento[column.dataKey]));
  
      // Verificar si se ajusta el contenido en la página actual
      const table = (doc as any).autoTable({
        head: [columns.map((column) => column.header)],
        body: tableData,
        startY: currentPage === 1 ? startY : 20, // 20 es un margen superior para las páginas siguientes
        styles: {
          fillColor: [255, 255, 255], // Color de fondo para las celdas del cuerpo
          textColor: [0, 0, 0], // Color del texto para las celdas del cuerpo
        },
        columnStyles: {
          0: { columnWidth: 70 }, // Ancho de la primera columna
          1: { columnWidth: 50 }, // Ancho de la segunda columna
          2: { columnWidth: 50 }, // Ancho de la tercera columna
          3: { columnWidth: 70 }, // Ancho de la cuarta columna
          4: { columnWidth: 30 }, // Ancho de la quinta columna
          5: { columnWidth: 50 }, // Ancho de la sexta columna
        },
        didDrawPage: function (data: any) {
          // Llamar a la función de encabezado en cada página
          header(doc);
  
          // Llamar a la función de pie de página en cada página
          footer(doc);
        },
      });
  
      // Obtener la altura total de la tabla en la página actual
      const tableHeight = table.height;
  
      // Verificar si se ajusta el contenido en la página actual
      if (tableHeight < availableSpace) {
        // Todavía hay espacio en la página actual para mostrar más contenido
        currentPage++;
        tableDataIndex += tableData.length;
      } else {
        // No hay suficiente espacio en la página actual para mostrar más contenido
        doc.addPage();
        currentPage = 1;
        availableSpace = pageHeight - startY - 20; // 20 es un margen inferior
      }
    }
  
    // Generar el PDF
    const pdfOutput = doc.output('blob');
  
    // Crear una URL a partir del blob
    const url = URL.createObjectURL(pdfOutput);
  
    // Mostrar el PDF en el visor
    this.pdfViewer.nativeElement.src = url;
  }
  
}
