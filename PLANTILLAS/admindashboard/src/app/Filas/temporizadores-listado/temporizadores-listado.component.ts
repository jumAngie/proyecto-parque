import { Component, ElementRef } from '@angular/core';
import { NgModel } from '@angular/forms';
import { Router } from '@angular/router';
import { Atracciones } from 'src/app/Models/Atracciones';
import { temporizadores } from 'src/app/Models/Temporizadores';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-temporizadores-listado',
  templateUrl: './temporizadores-listado.component.html',
  styleUrls: ['./temporizadores-listado.component.css'],
  providers: [NgModel]
})
export class TemporizadoresListadoComponent {

  private timer: any;
  private startTime: number = 0;
  private endTime: number = 0;

  constructor(
    private router: Router,
    private elementRef: ElementRef,
    private PService: ParqServicesService,
  ) {}

  tempo: temporizadores[] = [];
  tempoFiltrado: temporizadores[] = [];
  ddlAtracciones: Atracciones[] = [];
  atra_ID = 0;
  ticl_ID = "";
  p: number = 1;
  filtro: string = '';

  tiempoFaltante: string ="";
  AtaccionModal:string="";
  ClienteModal:string="";
  HoraExpira:string="";
  Posicion:Number=0;
  Expiracion:any;
  temp_ID=0;

  AtraccionRe=false;
  TicketRe=false;
  HoraRequerida=false;

  itemsPerPage = 10;
  paginacionConfig: any = {
    itemsPerPage: 10,
    currentPage: 1,
    totalItems: 0
  };
  listado=1;
  hora: number = 0;
  minuto: number = 0;

  actualizarHora(hora: number) {
    this.hora = Math.min(Math.max(hora, 0), 23);
  }

  actualizarMinuto(minuto: number) {
    this.minuto = Math.min(Math.max(minuto, 0), 59);
  }

  ngOnInit(): void {

    this.PService.getAtracciones()
    .subscribe((response: any) => {
      if (response.success) {
        this.ddlAtracciones = response.data;
      }
    });


    this.PService.getTemporizadores(this.listado).subscribe((data) => {
      this.tempo = data;

      this.tempoFiltrado = data;
      this.paginacionConfig.totalItems = this.tempo.length;
      console.log(this.tempo)
    });
  }

  
  
  filtrado(){
    this.tempoFiltrado = this.tempo.filter((tempo) => {
      return (
        tempo.cliente_Nombre.toLowerCase().includes(this.filtro.toLowerCase()) ||
        tempo.atra_Nombre.toLowerCase().includes(this.filtro.toLowerCase()) ||
        tempo.temp_Expiracion_Formateada.toString().toLowerCase().includes(this.filtro.toLowerCase()) ||
        tempo.tiempoFaltante.toString().toLocaleLowerCase().includes(this.filtro.toLowerCase())||
        tempo.posicion.toString().toLocaleLowerCase().includes(this.filtro.toLowerCase())

      );

    });

    this.paginacionConfig.totalItems = this.tempoFiltrado.length;

    this.paginacionConfig.totalItems = this.tempoFiltrado.length;
    this.paginacionConfig.currentPage = 1;
    this.tempoFiltrado = this.paginarFilas(this.tempoFiltrado);
  }

  paginarFilas(data: temporizadores[]): temporizadores[] {
    const startIndex = (this.paginacionConfig.currentPage - 1) * this.paginacionConfig.itemsPerPage;
    return data.slice(startIndex, startIndex + this.paginacionConfig.itemsPerPage);
  }
  
  onChangeItemsPerPage(event: Event) {
    const selectedValue = (event.target as HTMLInputElement)?.value;
    if (selectedValue !== null) {
      this.paginacionConfig.itemsPerPage = parseInt(selectedValue, 10);
      this.paginacionConfig.currentPage = 1;
      this.tempoFiltrado = this.paginarFilas(this.tempoFiltrado);
    }
  }


  Activos(){
    this.listado = 1;
    this.PService.getTemporizadores(this.listado).subscribe((data) => {
      this.tempo = data;

      this.tempoFiltrado = data;
      this.paginacionConfig.totalItems = this.tempo.length;
      console.log(this.tempo)
    });
  }

  Expirados(){
    this.listado=2;
    this.PService.getTemporizadores(this.listado).subscribe((data) => {
      this.tempo = data;

      this.tempoFiltrado = data;
      this.paginacionConfig.totalItems = this.tempo.length;
      console.log(this.tempo)
    });
  }


  Insert(){
    var Error = 0;

    if (this.ticl_ID=="") {
      
      this.TicketRe=true;
      Error=Error+1;
    }
    else{
      this.TicketRe=false;
    }

    if (this.atra_ID==0) {
      this.AtraccionRe=true;
      Error = Error+1;
    }
    else{
      this.AtraccionRe=false;
    }

    if (this.hora==0 || this.minuto==0) {
      this.HoraRequerida=true;
      Error = Error+1;
    }
    else{
      this.HoraRequerida=false;
    }

    if ((this.hora<0 || this.hora>23)|| (this.minuto<0 || this.minuto>60)) {
      this.HoraRequerida=true;
      Error = Error+1;
    }

    if (Error>0) {
      ToastUtils.showWarningToast("Hay Campos Vacios");
      return;
    }

    var tempExpiracion = this.hora.toString() + ":"+this.minuto.toString()+":00"

    this.PService.PostTemporizadores(this.ticl_ID,this.atra_ID,tempExpiracion).subscribe(
      (response: any) => {
      
        if (response.code==200) {
          ToastUtils.showSuccessToast( response.message);   
          setTimeout(() => {
          window.location.href = '/temporizadores'
        }, 1000);
        }
        if ( response.code==409) {
          ToastUtils.showWarningToast( response.message);   
        }
        if ( response.code==500) {
          ToastUtils.showErrorToast( response.message);   
        }
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  Extender() {
    var Error = 0;
  
  

  
    if (this.hora < 0) {
      this.HoraRequerida = true;
      Error = Error + 1;
    } else {
      this.HoraRequerida = false;
    }
  
    if (Error >= 1) {
      ToastUtils.showWarningToast("Hay Campos Vacios o que no cumplen su Formato");
      return;
    }
  
    var tempExpiracion = this.hora.toString() + ":" + this.minuto.toString() + ":00";
  
    if (this.PService) {
      this.PService.ExtenderTemporizadores(this.temp_ID, tempExpiracion).subscribe(
        (response: any) => {
          if (response.success) {
            ToastUtils.showSuccessToast(response.message);
            this.updateTempo();
          } else {
            ToastUtils.showErrorToast(response.message);
          }
        },
        (error: any) => {
          console.error('Error', error);
        }
      );
    } else {
      console.error('this.PService no está inicializado correctamente');
    }
  }
  
  updateTempo() {
    this.PService.getTemporizadores(this.listado).subscribe((data) => {
      this.tempo = data;
      this.tempoFiltrado = data;
      this.paginacionConfig.totalItems = this.tempo.length;
      console.log(this.tempo);
    });
  }

  Delete(){
    this.PService.DeleteTemporizador(this.temp_ID).subscribe(
      (response: any) => {
      
        if (response.code==200) {
          ToastUtils.showSuccessToast( response.message);   
          setTimeout(() => {
          window.location.href = '/temporizadores'
        }, 1000);
        }
        if ( response.code==409) {
          ToastUtils.showWarningToast( response.message);   
        }
        if ( response.code==500) {
          ToastUtils.showErrorToast( response.message);   
        }
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  DeleteCompleto(){
    this.PService.DeleteCompletoTemporizador().subscribe(
      (response: any) => {
      
        if (response.code==200) {
          ToastUtils.showSuccessToast( response.message);   
          setTimeout(() => {
          window.location.href = '/temporizadores'
        }, 1000);
        }
        if ( response.code==409) {
          ToastUtils.showWarningToast( response.message);   
        }
        if ( response.code==500) {
          ToastUtils.showErrorToast( response.message);   
        }
      },
      (error: any) => {
        console.error('Error al guardar el rol', error);
      }
    );
  }

  Modal(data: temporizadores) {
    this.temp_ID = data.temp_ID;

    this.AtraccionRe=false;
    this.TicketRe=false;
    this.HoraRequerida=false;

    const tiempoFaltanteEnSegundos = this.convertirTiempoAsegundos(data.tiempoFaltante);
    this.endTime = Date.now() + tiempoFaltanteEnSegundos * 1000;
    this.startTimer();
  
    this.AtaccionModal = data.atra_Nombre;
    this.ClienteModal = data.cliente_Nombre;
  
    // Extraer valores de hora y minuto de temp_Expiracion_Formateada
    const tiempoFormateado = data.temp_Expiracion_Formateada.trim(); // Eliminar espacios en blanco
    const isPM = tiempoFormateado.slice(-2).toLowerCase() === "pm"; // Comprobar si es PM
    const [horaString, minutoString] = tiempoFormateado.slice(0, -2).split(":"); // Eliminar "AM" o "PM" y dividir en hora y minuto
    let hora = Number(horaString);
    const minuto = Number(minutoString);
  
    // Ajustar la hora para el formato de 24 horas si es PM
    if (isPM && hora !== 12) {
      hora += 12;
    }
  
    // Asignar valores a las propiedades correspondientes
    this.HoraExpira = tiempoFormateado;
    this.Posicion = data.posicion;
    this.hora = hora;
    this.minuto = minuto;
  }
  
  

  private startTimer() {
    this.timer = setInterval(() => {
      const currentTime = Date.now();
      const remainingTime = Math.max(this.endTime - currentTime, 0);
      const minutes = Math.floor(remainingTime / 60000);
      const seconds = Math.floor((remainingTime % 60000) / 1000);

      this.tiempoFaltante = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

      if (remainingTime === 0) {
        this.stopTimer();
        // Lógica adicional cuando el tiempo se agota
      }
    }, 1000);
  }

  private stopTimer() {
    clearInterval(this.timer);
  }

  private convertirTiempoAsegundos(tiempo: string): number {
    const [minutos, segundos] = tiempo.split(':').map(Number);
    return minutos * 60 + segundos;
  }
  
  limitarCaracteres(event: any, maxLength: number) {
    if (event.target.value.length > maxLength) {
      event.target.value = event.target.value.slice(0, maxLength);
    }
  }
  
  
  Limpiar(){
    this.atra_ID=0;
    this.minuto=0;
    this.hora=0;
    this.ticl_ID="";
    this.AtraccionRe=false;
    this.TicketRe=false;
    this.HoraRequerida=false;
  }
}
