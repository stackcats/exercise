#include <gtk-3.0/gtk/gtk.h>

const gchar *first_name = "Alan";
const gchar *last_name = "Stackcats";

static void destroy(GtkWidget*, gpointer);
static void swap(GtkWidget*, GdkEventKey *, gpointer);
int main(int argc, char *argv[]) {
  gtk_init(&argc, &argv);

  GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window), first_name);
  gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
  gtk_widget_set_size_request(window, 300, 100);

  g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(destroy), NULL);

  GtkWidget *label = gtk_label_new(last_name);
  gtk_label_set_selectable(GTK_LABEL(label), TRUE);

  g_signal_connect(G_OBJECT(window), "key-press-event", G_CALLBACK(swap), (gpointer)label);
  
  gtk_container_add(GTK_CONTAINER(window), label);
  
  gtk_widget_show_all(window);
  
  gtk_main();
  
  return 0;
}

static void destroy(GtkWidget *widget, gpointer data) {
  gtk_main_quit();
}

static void swap(GtkWidget *widget, GdkEventKey *event, gpointer data) {
  const gchar *title = gtk_window_get_title(GTK_WINDOW(widget));
  if (!g_ascii_strcasecmp(title, first_name)) {
    gtk_window_set_title(GTK_WINDOW(widget), last_name);
    gtk_label_set_text(GTK_LABEL(data), first_name);
  } else {
    gtk_window_set_title(GTK_WINDOW(widget), first_name);
    gtk_label_set_text(GTK_LABEL(data), last_name);
  }
}
